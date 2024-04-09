-- Item Duplicator v1.0.2
-- SmoothSpatula

-- ========== Loading ==========

mods.on_all_mods_loaded(function() for k, v in pairs(mods) do if type(v) == "table" and v.tomlfuncs then Toml = v end end 
    params = {
        repeat_number = 2,
        repeat_item_enabled = true
    }
    params = Toml.config_update(_ENV["!guid"], params)
end)

-- Parameters
local isChanged = false

-- ========== ImGui ==========

gui.add_to_menu_bar(function()
    local new_value, clicked = ImGui.Checkbox("Enable Repeat Item", params['repeat_item_enabled'])
    if clicked then
        params['repeat_item_enabled'] = new_value
        Toml.save_cfg(_ENV["!guid"], params)
    end
end)

gui.add_to_menu_bar(function()
    local new_value, isChanged = ImGui.InputInt("Number of item", params['repeat_number'], 1, 2, 0)
    if isChanged then
        params['repeat_number'] = new_value
        Toml.save_cfg(_ENV["!guid"], params)
    end
end)

-- ========== Main ==========

gm.pre_script_hook(gm.constants.item_give, function(self, other, result, args)
    if not params['repeat_item_enabled'] then return end
    local item_id = args[2].value
    if item_id>112 and item_id<136 then return end -- Special items that shouldnt be duplicated (vanilla items have ids under 112 and moded items should have ids over 136)
    args[3].value = params['repeat_number']
end)
