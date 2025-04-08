function BMsg(msg)
	ChatFrame1:AddMessage(msg or 'nil', 0, 1, 0.4)
end

BindingButtonsAliases = {
    ["ActionButton"] = "ACTIONBUTTON",
    ["BActionButton"] = "ACTIONBUTTON",
    ["MultiBarBottomLeftButton"] = "MULTIACTIONBAR1BUTTON",
    ["MultiBarBottomRightButton"] = "MULTIACTIONBAR2BUTTON",
    ["MultiBarRightButton"] = "MULTIACTIONBAR3BUTTON",
    ["MultiBarLeftButton"] = "MULTIACTIONBAR4BUTTON",
    ["ShapeshiftButton"] = "SHAPESHIFTBUTTON",
    ["BClassBarButton"] = "SHAPESHIFTBUTTON",
    ["PetActionButton"] = "BONUSACTIONBUTTON",
};


function IsActionFrame(frame)
    local buttonName = _splitString(frame, "%d+");

    if BindingButtonsAliases[buttonName] then
        return true
    else
        return false
    end

end

function GetBindingName(button, bongoed)
    local buttonName = _splitString(button, "%d+");
    local bindingName = BindingButtonsAliases[buttonName]
    local buttonNumber = _splitString(button, "%a+")

    -- Bongos
    if(bongoed) then

        if(bindingName == "MULTIACTIONBAR1BUTTON") then
            buttonNumber = tonumber(buttonNumber) + 12
        elseif (bindingName == "MULTIACTIONBAR2BUTTON") then
            buttonNumber = tonumber(buttonNumber) + 24
        elseif (bindingName == "MULTIACTIONBAR3BUTTON") then
            buttonNumber = tonumber(buttonNumber) + 36
        elseif (bindingName == "MULTIACTIONBAR4BUTTON") then
            buttonNumber = tonumber(buttonNumber) + 48
        else
        end

        bindingName = "ACTIONBUTTON"

    end
        
    return bindingName..buttonNumber;

end

function _splitString(str, seperatorPattern)

    local tbl = {};
    local pattern = "(.-)" .. seperatorPattern;
    local lastEnd = 1;
    local s, e, cap = string.find(str, pattern, 1);
   
    while s do
        if s ~= 1 or cap ~= "" then
            table.insert(tbl,cap);
        end
        lastEnd = e + 1;
        s, e, cap = string.find(str, pattern, lastEnd);
    end
    
    if lastEnd <= string.len(str) then
        cap = string.sub(str, lastEnd);
        table.insert(tbl, cap);
    end
    
    return tbl[1]

end
