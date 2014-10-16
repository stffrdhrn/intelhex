#!/usr/bin/env ruby

# Generate a sine wave in hex, for use as testing input

amplitude = 127
offset = 127
samples = 100
i = 0

while i < samples do
  sin_val = Math::sin((i.to_f / samples) * (2 * Math::PI))
  sin_val = offset + (amplitude * sin_val)
  printf "%02x", sin_val
  i += 1
end
