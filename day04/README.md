# Day 4

## Language

[Python](https://www.python.org/) is maybe the easiest language to learn on, and an old favorite that I don't use often any more. This language runs relatively quickly, has easily readable syntax, and has a library for about everything. If you don't know about it already, check it out!

## Implementation

Both parts are simple here.

For part 1, I have flags I read as I go to ensure that 

 a) Each number is greater than or equal to the last.

 b) One number occurs at least twice.

For part 2, I make a small tweak: If a sequence ends after 2 characters, the double flag is set. The double flag is only set if a sequence ends after 2 characters, and the function only reports a password as valid if either double is set, or the number of consecutive characters is exactly 2 at the end.