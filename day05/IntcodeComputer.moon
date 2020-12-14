--- An intcode computer, for processing programs.
--  Preserving this version of it, will include updated versions in future puzzles if needed.
parameterMode = (position, codes, mode, pos) ->
    x = math.floor((mode % 10^pos)/(10^(pos-1)))
    if x==0
        return codes[position + pos] + 1
    elseif x==1
        return position + pos

class Computer
    opcodes:    -- Just store valid opcodes in a table here. Very expandible.
        [1]: (position, codes, mode) ->
            x = parameterMode position, codes, mode, 1
            y = parameterMode position, codes, mode, 2
            t = parameterMode position, codes, mode, 3
            codes[t] = codes[x] + codes[y]
            position + 4
        [2]: (position, codes, mode) ->
            x = parameterMode position, codes, mode, 1
            y = parameterMode position, codes, mode, 2
            t = parameterMode position, codes, mode, 3
            codes[t] = codes[x] * codes[y]
            position + 4
        [3]: (position, codes, mode) ->
            x = parameterMode position, codes, mode, 1
            print("[Input]:")
            i = tonumber (io.read!)
            while not i do
                print("Must be a valid integer")
                print("[Input]:")
                i = tonumber (io.read!)
            codes[x] = i
            position + 2
        [4]: (position, codes, mode) ->
            x = parameterMode position, codes, mode, 1
            print(codes[x])
            position + 2
        [5]: (position, codes, mode) ->
            x = parameterMode position, codes, mode, 1
            y = parameterMode position, codes, mode, 2
            if codes[x] != 0
                return codes[y] + 1
            position + 3
        [6]: (position, codes, mode) ->
            x = parameterMode position, codes, mode, 1
            y = parameterMode position, codes, mode, 2
            if codes[x] == 0
                return codes[y] + 1
            position + 3
        [7]: (position, codes, mode) ->
            x = parameterMode position, codes, mode, 1
            y = parameterMode position, codes, mode, 2
            t = parameterMode position, codes, mode, 3
            codes[t] = 0
            if codes[x] < codes[y]
                codes[t] = 1
            position + 4
        [8]: (position, codes, mode) ->
            x = parameterMode position, codes, mode, 1
            y = parameterMode position, codes, mode, 2
            t = parameterMode position, codes, mode, 3
            codes[t] = 0
            if codes[x] == codes[y]
                codes[t] = 1
            position + 4
        [99]: (position, codes, mode) -> false

    new: (input) =>
        @codes = for v in input\gmatch "[^,]+" do tonumber v
        @pointer = 1

    step: =>
        x = @codes[@pointer]
        code = @opcodes[x % 100]
        success, result = pcall code, @pointer, @codes, math.floor(x / 100)
        if not success
            print("Failure at "..(@pointer-1))
            print("\tAt instruction "..x)
            print(result)
        if result == false
            return result
        else
            @pointer = result
        true
    
    run: =>
        while @\step! do true

{ :Computer }