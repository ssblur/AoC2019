--- Advent of Code 2019 Day 2.
--  Written in Moonscript, docs follow LDoc's conventions.
--  @author Patrick Emery

import Computer from require "IntcodeComputer"

input = (io.open "input.txt", "r")\read("*all") -- Get our input.
computer = Computer input   -- Computer automatically processes input.
computer.codes[2] = 12  -- Set the codes we need to tweak before running.
computer.codes[3] = 2
computer\run!   -- Run the computer
print computer.codes[1] -- Print the result we're looking for.