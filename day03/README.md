# Day 3

## Language

[Perl](https://www.perl.org/) is a classic for server owners and hobbyists alike... as long as you picked it up years ago. I am only familiar with it because I specialize in working on legacy projects.

## Implementation

For part 1, I generated line segment endpoints and created a simplified intersection detector. If they intersect, I dump the location of the intersection to a variable if its distance is closer than the previous one.

Part 2 is modified to count distance as it goes rather than measuring the distance from the origin.