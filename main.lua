-- Item Duplicator v1.0.0
-- SmoothSpatula

local repeat_item_enabled = true
local isChanged = false

-- Parameters
local repeat_number = 10

-- ========== ImGui ==========

gui.add_to_menu_bar(function()
    local new_value, clicked = ImGui.Checkbox("Enable Repeat Item", repeat_item_enabled)
    if clicked then
        repeat_item_enabled = new_value
    end
end)

gui.add_to_menu_bar(function()
    local new_value, isChanged = ImGui.InputInt("Number of item", repeat_number, 1, 2, 0)
    if isChanged then
        repeat_number = new_value
    end
end)

-- ========== Main ==========

gm.pre_script_hook(gm.constants.item_give, function(self, other, result, args)
    local item_id = args[2].value
    if item_id>112 and item_id<136 then return end -- Special items that shouldnt be duplicated (vanilla items have ids under 112 and moded items should have ids over 136)
    if repeat_item_enabled then args[3].value = repeat_number end
end)
