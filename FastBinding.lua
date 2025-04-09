local FastBinding =  {};
FastBinding.Frame = CreateFrame("Frame");

FastBinding.Enabled = false;

function FastBinding.Frame:OnKeyDown(key)

    local frame = GetMouseFocus():GetName();

    -- ENTER always disables FastBinding
    if key == "ENTER" then
        FastBinding.Enable(false)
        return
    end

    -- Ignore modifier keys
    if key == "ALT" or key == "SHIFT" or key == "CTRL" then
        return
    end

    if IsActionFrame(frame) then
        -- ESCAPE on ActionButton resets binding
        if key == "ESCAPE" then
            FastBinding.ResetActionButton(frame)
        else
            FastBinding.SetKeyToActionButton(key, frame)
        end
    else
        -- ESCAPE out ActionButton disables FB
        if key == "ESCAPE" then
            FastBinding.Enable(false)
        end
    end

end

function FastBinding.SetKeyToActionButton(key, actionButton)

    local bindingName = GetBindingName(actionButton, true);

    if (IsShiftKeyDown()) then
        key = "SHIFT-"..key;
    end
    if (IsControlKeyDown()) then
        key = "CTRL-"..key;
    end
    if (IsAltKeyDown()) then
        key = "ALT-"..key;
    end

    local usedKey = GetBindingKey(bindingName);
    if usedKey then
        SetBinding(usedKey);
    end

    if SetBinding(key, bindingName, 1) then
        BMsg("Set "..key.. " to "..bindingName);
    end

    SaveBindings(2);

end

function FastBinding.ResetActionButton(actionButton)

    local bindingName = GetBindingName(actionButton, true);
    local usedKey = GetBindingKey(bindingName);
    if usedKey then
        SetBinding(usedKey);
        BMsg("Removed "..usedKey.." from "..bindingName);
        SaveBindings(2);
    end

end

function FastBinding.Enable(enable)

    FastBinding.Enabled = enable;

    if enable then
        FastBinding.Frame:EnableKeyboard(true);
        FastBinding.Frame:SetScript("OnKeyDown", function()
            local key = arg1;
            this:OnKeyDown(key);
        end);
        BMsg("FastBinding enabled press ENTER or ESCAPE (with mouse out of action bars) to disable");

    else
        FastBinding.Frame:EnableKeyboard(nil);
        FastBinding.Frame:SetScript("OnKeyDown", nil);
        BMsg("FastBinding disabled");
    end

end

-- Set command action
SLASH_FASTBINDING1 = "/fb";

SlashCmdList["FASTBINDING"] = function(cmd)
    if FastBinding.Enabled then
        FastBinding.Enable(false)
    else
        FastBinding.Enable(true)
    end
end