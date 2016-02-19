local function table_contains(v, t)
	for _,i in ipairs(t) do
		if i == v then
			return true
		end
	end
	return false
end

local diamond_capabs = minetest.registered_tools["default:pick_diamond"].tool_capabilities


--silk touch pick

minetest.register_tool("special_picks:silk_touch_pick", {
	description = "Silk Touch Pickaxe",
	inventory_image = "special_picks_silk_touch_pick.png",
	tool_capabilities = diamond_capabs,
})

local special_tools = {}
local function add_tool(name, func)
	special_tools[name] = func
end

minetest.register_on_dignode(function(_, oldnode, digger)
	if digger == nil then
		return
	end
	local func = special_tools[digger:get_wielded_item():get_name()]
	if func
	and oldnode.name ~= "air" then
		func(digger, oldnode)
	end
end)

add_tool("special_picks:silk_touch_pick", function(digger, oldnode)
	local inv = digger:get_inventory()
	if inv then
		local free_slots = 0
		for _,i in pairs(inv:get_list("main")) do
			if i:get_count() == 0 then
				free_slots = free_slots+1
				break
			end
		end
		if free_slots == 0 then
			return
		end
		local nd = oldnode.name
		local items = minetest.get_node_drops(nd)
		local first_item = items[1]
		if not first_item then
			return
		end
		if first_item == nd then
			return
		end
		for _,item in ipairs(items) do
			inv:remove_item("main", item)
		end
		inv:add_item("main", nd)
	end
end)

minetest.register_craftitem("special_picks:soft_diamond", {
	description = "Soft Diamond",
	inventory_image = "special_picks_soft_diamond.png",
})

minetest.register_craft({
	output = "special_picks:soft_diamond",
	recipe = {
		{"group:wool", "default:coalblock","group:wool"},
		{"default:obsidian", "default:diamond","default:obsidian"},
		{"group:wool", "default:obsidian","group:wool"},
	}
})

minetest.register_craft({
	output = "special_picks:silk_touch_pick",
	recipe = {
		{"special_picks:soft_diamond", "special_picks:soft_diamond", "special_picks:soft_diamond"},
		{"", "group:stick", ""},
		{"", "group:stick", ""},
	}
})


--fortune pick

minetest.register_tool("special_picks:fortune_pick", {
	description = "Fortune Pickaxe",
	inventory_image = "special_picks_fortune_pick.png",
	tool_capabilities = diamond_capabs,
})

local allowed_nodes = {"technic:mineral_sulfur","technic:mineral_lead","technic:mineral_zinc","technic:mineral_chromium","technic:mineral_uranium","default:mineral_silver","default:mineral_tin","default:mineral_copper", "moreores:mineral_silver","moreores:mineral_mithril","moreores:mineral_tin","default:stone_with_coal","default:stone_with_iron","default:stone_with_copper","default:stone_with_mese", "default:stone_with_gold","default:stone_with_diamond"}

add_tool("special_picks:fortune_pick", function(digger, oldnode)
	local nam = oldnode.name
	if not table_contains(nam, allowed_nodes) then
		return
	end
	if math.random(2) == 1 then
		return
	end
	local inv = digger:get_inventory()
	if inv then
		local items = minetest.get_node_drops(nam)
		for _,item in ipairs(items) do
			inv:add_item("main", item)
		end
	end
end)

minetest.register_craftitem("special_picks:fortune_diamond", {
	description = "Fortune Diamond",
	inventory_image = "special_picks_fortune_diamond.png",
})

minetest.register_craft({
	output = "special_picks:fortune_diamond",
	recipe = {
		{"default:goldblock", "default:mese", "default:goldblock"},
		{"default:copperblock", "default:diamond", "default:copperblock"},
		{"default:steelblock", "default:mese", "default:steelblock"},
	}
})

minetest.register_craft({
	output = "special_picks:fortune_diamond",
	recipe = {
		{"moreores:silver_block", "moreores:mithril_block", "moreores:silver_block"},
		{"moreores:tin_block", "default:diamond", "moreores:tin_block"},
		{"default:steelblock", "moreores:mithril_block", "default:steelblock"},
	}
})

minetest.register_craft({
	output = "special_picks:fortune_diamond",
	recipe = {
		{"default:silverblock", "default:mese", "default:silverblock"},
		{"default:tinblock", "default:diamond", "default:tinblock"},
		{"default:copperblock", "default:mese", "default:copperblock"},
	}
})


minetest.register_craft({
	output = "special_picks:fortune_pick",
	recipe = {
		{"special_picks:fortune_diamond", "special_picks:fortune_diamond", "special_picks:fortune_diamond"},
		{"", "group:stick", ""},
		{"", "group:stick", ""},
	}
})


--big diamond pick

local capabs = table.copy(diamond_capabs)
capabs.groupcaps.cracky.uses = capabs.groupcaps.cracky.uses*9

minetest.register_tool("special_picks:big_diamondpick", {
	description = "Big Diamond Pickaxe",
	inventory_image = "special_picks_big_diamondpick.png",
	tool_capabilities = capabs,
})

minetest.register_craft({
	output = "special_picks:big_diamondpick",
	recipe = {
		{"default:diamondblock", "default:diamondblock", "default:diamondblock"},
		{"", "group:tree", ""},
		{"", "group:tree", ""},
	}
})


--battle pick

local capabs = table.copy(diamond_capabs)
capabs.damage_groups.fleshy = capabs.damage_groups.fleshy*2

minetest.register_tool("special_picks:battle_pick", {
	description = "Battle Pickaxe",
	inventory_image = "special_picks_battle_pick.png",
	tool_capabilities = capabs,
})

minetest.register_craftitem("special_picks:abrasive_paper", {
	description = "Abrasive Paper",
	inventory_image = "special_picks_abrasive_paper.png",
})

minetest.register_craftitem("special_picks:pointed_diamond", {
	description = "Pointed Diamond",
	inventory_image = "special_picks_pointed_diamond.png",
})

minetest.register_craft({
	output = "special_picks:abrasive_paper 3",
	recipe = {
		{"default:sandstone", "default:sandstone", "default:sandstone"},
		{"default:paper", "default:paper", "default:paper"},
	}
})

minetest.register_craft({
	output = "special_picks:pointed_diamond",
	recipe = {
		{"", "special_picks:abrasive_paper", ""},
		{"special_picks:abrasive_paper", "default:diamond", "special_picks:abrasive_paper"},
		{"", "special_picks:abrasive_paper", ""},
	}
})

minetest.register_craft({
	output = "special_picks:battle_pick",
	recipe = {
		{"special_picks:pointed_diamond", "special_picks:pointed_diamond", "special_picks:pointed_diamond"},
		{"", "group:stick", ""},
		{"", "group:stick", ""},
	}
})


--fire pick

local capabs = table.copy(diamond_capabs)
capabs.damage_groups.fleshy = capabs.damage_groups.fleshy+1

minetest.register_tool("special_picks:fire_pick", {
	description = "Fire Pickaxe",
	inventory_image = "special_picks_fire_pick.png",
	tool_capabilities = capabs,
})

add_tool("special_picks:fire_pick", function(digger, node)
	local inv = digger:get_inventory()
	if inv then
		local nam = node.name
		local drops = minetest.get_node_drops(nam)
		local result = minetest.get_craft_result({method = "cooking", width = 1, items = drops})["item"]
		if result:is_empty() then
			return
		end
		for _,item in ipairs(drops) do
			inv:remove_item("main", item)
		end
		inv:add_item("main", result)
	end
end)

minetest.register_craftitem("special_picks:hot_diamond", {
	description = "Hot Diamond",
	inventory_image = "special_picks_hot_diamond.png",
})

minetest.register_craft({
	output = "special_picks:hot_diamond",
	recipe = {
		{"default:coalblock", "bucket:bucket_lava", "default:coalblock"},
		{"bucket:bucket_lava", "default:diamond", "bucket:bucket_lava"},
		{"default:coal_lump", "bucket:bucket_lava", "default:coal_lump"},
	},
	replacements = {
		{"default:coalblock", "default:coal_lump 2"},
		{"default:coalblock", "default:coal_lump 2"},
		{"bucket:bucket_lava", "bucket:bucket_empty"},
		{"bucket:bucket_lava", "bucket:bucket_empty"},
		{"bucket:bucket_lava", "bucket:bucket_empty"},
		{"bucket:bucket_lava", "bucket:bucket_empty"},
	}
})

minetest.register_craft({
	output = "special_picks:fire_pick",
	recipe = {
		{"special_picks:hot_diamond", "special_picks:hot_diamond", "special_picks:hot_diamond"},
		{"", "group:stick", ""},
		{"", "group:stick", ""},
	}
})


--liquid transportation pick

--[[minetest.register_tool("special_picks:liquid_transportation_pick", {
	description = "Liquid Transportation Pickaxe",
	inventory_image = "special_picks_fire_pick.png",
	tool_capabilities = {
		full_punch_interval = 0.9,
		max_drop_level=3,
		groupcaps={
			cracky = {times={[1]=2.0, [2]=1.0, [3]=0.50}, uses=30, maxlevel=3}
		},
		damage_groups = {fleshy=5},
	},
})]]


--glass steel pick

local glass_pick_capabs = table.copy(diamond_capabs)
local cracky = glass_pick_capabs.groupcaps.cracky
for n,i in pairs(cracky.times) do
	cracky.times[n] = i/2
end
cracky.uses = 8
cracky.maxlevel = 2
glass_pick_capabs.damage_groups.fleshy = glass_pick_capabs.damage_groups.fleshy-1

minetest.register_tool("special_picks:glass_steel_pick", {
	description = "Glass Steel Pickaxe",
	inventory_image = "special_picks_glass_steel_pick.png",
	tool_capabilities = glass_pick_capabs,
})

minetest.register_craftitem("special_picks:glass_steel_ingot", {
	description = "Glass Steel Ingot",
	inventory_image = "special_picks_glass_steel_ingot.png",
})

minetest.register_craft({
	output = "special_picks:glass_steel_ingot",
	recipe = {
		{"default:glass", "default:glass", "default:glass"},
		{"default:glass", "default:steel_ingot", "default:glass"},
		{"default:glass", "default:glass", "default:glass"},
	}
})

minetest.register_craft({
	output = "special_picks:glass_steel_pick",
	recipe = {
		{"special_picks:glass_steel_ingot", "special_picks:glass_steel_ingot", "special_picks:glass_steel_ingot"},
		{"", "group:stick", ""},
		{"", "group:stick", ""},
	}
})

minetest.register_node("special_picks:glass_steel_block", {
	description = "Glass Steel Block",
	drawtype = "glasslike",
	tiles = {"special_picks_glass_steel_block.png"},
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = true,
	groups = {cracky=1,level=2},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_craft({
	output = "special_picks:glass_steel_block",
	recipe = {
		{"special_picks:glass_steel_ingot", "special_picks:glass_steel_ingot", "special_picks:glass_steel_ingot"},
		{"special_picks:glass_steel_ingot", "special_picks:glass_steel_ingot", "special_picks:glass_steel_ingot"},
		{"special_picks:glass_steel_ingot", "special_picks:glass_steel_ingot", "special_picks:glass_steel_ingot"},
	}
})


glass_pick_capabs.groupcaps.cracky.uses = glass_pick_capabs.groupcaps.cracky.uses*9

minetest.register_tool("special_picks:big_glass_steel_pick", {
	description = "Big Glass Steel Pickaxe",
	inventory_image = "special_picks_big_glass_steel_pick.png",
	tool_capabilities = glass_pick_capabs,
})

minetest.register_craft({
	output = "special_picks:big_glass_steel_pick",
	recipe = {
		{"special_picks:glass_steel_block", "special_picks:glass_steel_block", "special_picks:glass_steel_block"},
		{"", "group:tree", ""},
		{"", "group:tree", ""},
	}
})

--explosion pick

--[[minetest.register_tool("special_picks:explosion_pick", {
	description = "Explosion Pickaxe",
	inventory_image = "special_picks_explosion_pick.png",
	tool_capabilities = {
		full_punch_interval = 0.9,
		max_drop_level=3,
		groupcaps={
			cracky = {times={[1]=2.0, [2]=1.0, [3]=0.50}, uses=30, maxlevel=3}
		},
		damage_groups = {fleshy=5},
	},
})]]

--i need help with this pick

