#!/usr/bin/env ruby
#
# Very simple utility for creating a index hex formatted file. 
# Intel hex is used for uploading data into hardware roms like
# those found on FPGAs. The fpga IDE's like to use intelhex. 
#
# For more details on the format see the wiki:
#  http://en.wikipedia.org/wiki/Intel_HEX
#
# Each line outputted contains:
#  - Bytecount   (2 bytes)
#  - Address     (4 bytes)
#  - Record Type (2 bytes)
#  - Data  
#  - Checksum    (2 bytes)
#

require 'getoptlong'

opts = GetoptLong.new(
  [ '--address', '-a' , GetoptLong::OPTIONAL_ARGUMENT ]
)

# Calculate the checksum of the bytes
# Add length + address bytes + bytes then take the 2's compliment
def calc_checksum(address, bytes)
  checksum = bytes.length
  checksum += (address & 0xff00) >> 8
  checksum += (address & 0x00ff)
  bytes.collect { |b| checksum += b }

  checksum &= 0x00ff
  checksum ^= 0x00ff
  checksum += 1
end

def print_line(address, bytes)
  checksum = calc_checksum(address, bytes)

  bytes_hex = ""
  bytes.collect { |b| bytes_hex << "%02x" % b }
  printf ":%02x%04x00%s%02x\n", bytes.length, address, bytes_hex, checksum
end

# Main
#
# Set Defaults
address = 0x0000
width   = 16
bytes   = Array.new

opts.each do |opt, arg|
  case opt
    when '--address'
      address = arg.to_i
  end
end

# Read stdin
f = STDIN;
b = f.getbyte
while !b.nil? do
  bytes << b
  if (bytes.length == width) then
    print_line(address, bytes)
    address += bytes.length
    bytes.clear
  end
  b = f.getbyte
end

# Print extra lines
if (bytes.length > 0) then
  print_line(address, bytes)
end

# End of record is always this
print ":00000001ff\n"
