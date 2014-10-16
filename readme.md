# _Ruby Intel Hex Creator_

_Description: _ 

Very simple utility for creating a index hex formatted file. 
Intel hex is used for uploading data into hardware roms like
those found on FPGAs. The fpga IDE''s like to use intelhex. 

For more details on the format see the wiki:
 http://en.wikipedia.org/wiki/Intel_HEX

Each line outputted contains:
 - Bytecount   (2 bytes)
 - Address     (4 bytes)
 - Record Type (2 bytes)
 - Data  
 - Checksum    (2 bytes)

## TODO

## Project Setup
Its just a script, use it where you want. 

## License
BSD
