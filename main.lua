-- Item Duplicator v1.0.3
-- SmoothSpatula

-- ========== Loading ==========
mods.on_all_mods_loaded(function() for _, m in pairs(mods) do if type(m) == "table" and m.RoRR_Modding_Toolkit then for _, c in ipairs(m.Classes) do if m[c] then _G[c] = m[c] end end end end end)

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

function __initialize()
    Callback.add("onPickupCollected", "SmoothSpatula-ItemDuplicator-Pickup", function(self, other, result, args)
        if (not params['repeat_item_enabled']) 
            or self.tier==Item.TIER.special 
            or self.tier==Item.TIER.equipment 
            or self.tier>=Item.TIER.notier then return end
        if params['repeat_number'] > 1 then gm.item_give(other, self.item_id, params['repeat_number']-1) end
    end)
end
