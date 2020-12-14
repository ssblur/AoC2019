--- Advent of Code 2019 Day 2.
--  Written in Moonscript, docs follow LDoc's conventions.
--  @author Patrick Emery

import Computer from require "IntcodeComputer"

input = (io.open "input.txt", "r")\read("*all") -- Get our input.
computer = Computer input   -- Computer automatically processes input.
computer\run!   -- Run the computer