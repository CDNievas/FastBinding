-- Setup globals
local _G = _G or getfenv(0);
local FastBinding = _G.FastBinding or {};
_G.FastBinding = FastBinding;

FastBinding.Enabled = false;
FastBinding.Frame = CreateFrame("FRAME");

function FastBinding.Frame:OnKeyDown(key)
    local frame = GetMouseFocus();

    if key == "ENTER" or key == "ESCAPE" then
        FastBinding.Enable(false);
    elseif key == "ALT" or key == "SHIFT" or key == "CTRL" then
    else
        if IsActionFrame(frame:GetName()) then
            FastBinding.SetKeyToActionButton(key, frame:GetName());
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
        SaveBindings(2);
        BMsg("Setted "..key.. " to "..bindingName);
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
        BMsg("FastBinding enabled press ESCAPE or ENTER to disable");

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