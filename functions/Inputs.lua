GetInputs = {}
GetInputs.Keybinds = {up = "up", down = "down", left = "left", right = "right", select = "c", exit = "x"}
GetInputs.trackInputs = {}
for k, v in pairs(GetInputs.Keybinds) do
    GetInputs.trackInputs[k] = 0
end

function GetInputs.update()
    --get each key and value in keybinds
    for k, v in pairs(GetInputs.Keybinds) do

        if(love.keyboard.isDown(GetInputs.Keybinds[k])) then
            --1 for first frame pressed, 2 for held
            if(GetInputs.trackInputs[k] == 0) then
                GetInputs.trackInputs[k] = 1
            elseif(GetInputs.trackInputs[k] == 1) then
                GetInputs.trackInputs[k] = 2
            end

        else
            --0 for not pressed
            GetInputs.trackInputs[k] = 0
        end

    end
end

function GetInputs.held(key)
    return GetInputs.trackInputs[key] == 2 or GetInputs.trackInputs[key] == 1
end

function GetInputs.tap(key)
    return GetInputs.trackInputs[key] == 1
end
