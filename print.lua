Print = {}

Print.Colors = {
    ["red"]    = {1.0, 0.0, 0.0},
    ["green"]  = {0.0, 1.0, 0.0},
    ["blue"]   = {0.0, 0.0, 1.0},
    ["yellow"] = {1.0, 1.0, 0.0},
    ["cyan"]   = {0.0, 1.0, 1.0},
    ["magenta"]= {1.0, 0.0, 1.0},
    ["white"]  = {1.0, 1.0, 1.0},
    ["gray"]   = {0.5, 0.5, 0.5},
    ["black"]  = {0.0, 0.0, 0.0},
    ["orange"] = {1.0, 0.5, 0.0},
    ["purple"] = {0.5, 0.0, 0.5},
}

function Print.Chat(msg, color)
    local c = Print.Colors[color] or Print.Colors["gray"]
	ChatFrame1:AddMessage("FastBinding - "..msg, c[1], c[2], c[3])
end

function Print.Debug(msg, color)
    if FastBinding.Debug then
        local c = Print.Colors[color] or Print.Colors["red"]
	    ChatFrame1:AddMessage("[DEBUG] - "..msg, c[1], c[2], c[3])
    end
end