# Day 2

## Language

The language used today is Moonscript, because I enjoy using it and don't get to frequently. Moonscript is a scripting language meant to compile into Lua, adding more support for objected oriented concepts like class, plus other nicetied like string formatting, nicer formatting, table comprehension, better scope management, and more.

Notable is that all indices have been offset by 1 due to Lua (and, by extension Moonscript) starting lists from 1.

Check it out on [its website](https://moonscript.org/).

## Implementation

For Part 1, I built a class which represents an Intcode computer, then set it up, changed the codes at positions 2(1) and 3(2). After running it, I extract the answer from position 1(0), and we're golden!

For Part 2, I run the same computer class from part 1, but use loops to set the inputs, and print out the answer to the puzzle if the answer at position 1(0) is correct. This is not a lazy loop, so if somehow there are multiple answers in `noun = [0, 99], verb = [0, 99]`, it will find all of them.