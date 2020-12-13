--- Advent of Code 2019 Day 2.
--  Written in Moonscript, docs follow LDoc's conventions.
--  @author Patrick Emery

import Computer from require "IntcodeComputer"

input = (io.open "input.txt", "r")\read("*all") -- Get our input.
for x = 0, 99, 1 -- Brute force it.
    for y = 0, 99, 1
        computer = Computer input
        computer.codes[2] = x
        computer.codes[3] = y
        computer\run!
        if computer.codes[1] == 19690720
            print 100 * x + y