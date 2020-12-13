--- An intcode computer, for processing programs.
--  Preserving this version of it, will include updated versions in future puzzles if needed.
class Computer
    opcodes:    -- Just store valid opcodes in a table here. Very expandible.
        [1]: (position, codes) ->
            x = codes[position + 1] + 1 -- Ugh, Lua and its "indices start from 1"
            y = codes[position + 2] + 1
            t = codes[position + 3] + 1
            codes[t] = codes[x] + codes[y]
            true
        [2]: (position, codes) ->
            x = codes[position + 1] + 1
            y = codes[position + 2] + 1
            t = codes[position + 3] + 1
            codes[t] = codes[x] * codes[y]
            true
        [99]: (position, codes) -> false

    new: (input) =>
        @codes = for v in input\gmatch "[^,]+" do tonumber v
        @pointer = 1

    step: =>
        code = @opcodes[@codes[@pointer]]
        result = code @pointer, @codes
        @pointer += 4
        result
    
    run: =>
        while @\step! do true

{ :Computer }