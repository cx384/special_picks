local function table_contains(v, t)
	for _,i in ipairs(t) do
		if i == v then
			return true
		end
	end
	return false
end

--silk touch pick

minetest.register_tool("special_picks:silk_touch_pick", {
	description = "silk touch pick",
	inventory_image = "default_tool_diamondpick.png",
	tool_capabilities = {
		full_punch_interval = 0.9,
		max_drop_level=3,
		groupcaps={
			cracky = {times={[1]=2.0, [2]=1.0, [3]=0.50}, uses=30, maxlevel=3}
		},
		damage_groups = {fleshy=5},
	},
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

minetest.register_craftitem("special_picks:silk_touch_diamond", {
	description = "silk touch diamond",
	inventory_image = "default_diamond.png",
})

minetest.register_craft({
	output = "special_picks:silk_touch_diamond",
	recipe = {
		{"group:wool", "default:coalblock","group:wool"},
		{"default:obsidian", "default:diamond","default:obsidian"},
		{"group:wool", "default:obsidian","group:wool"},
	}
})

minetest.register_craft({
	output = "special_picks:silk_touch_pick",
	recipe = {
		{"special_picks:silk_touch_diamond", "special_picks:silk_touch_diamond", "special_picks:silk_touch_diamond"},
		{"", "group:stick", ""},
		{"", "group:stick", ""},
	}
})


--battle pick

minetest.register_tool("special_picks:battle_pick", {
	description = "battle pick",
	inventory_image = "default_tool_diamondpick.png",
	tool_capabilities = {
		full_punch_interval = 0.9,
		max_drop_level=3,
		groupcaps={
			cracky = {times={[1]=2.0, [2]=1.0, [3]=0.50}, uses=30, maxlevel=3}
		},
		damage_groups = {fleshy=10},
	},
})

--fortune pick

minetest.register_tool("special_picks:fortune_pick", {
	description = "fortune pick",
	inventory_image = "special_picks_fortune_pick.png",
	tool_capabilities = {
		full_punch_interval = 0.9,
		max_drop_level=3,
		groupcaps={
			cracky = {times={[1]=2.0, [2]=1.0, [3]=0.50}, uses=30, maxlevel=3}
		},
		damage_groups = {fleshy=5},
	},
})

local allowed_nodes = { "default:stone_with_coal","default:stone_with_iron","default:stone_with_copper","default:stone_with_mese", "default:stone_with_gold","default:stone_with_diamond"}

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
	description = "fortune diamond",
	inventory_image = "default_diamond.png",
})

minetest.register_craft({
	output = "special_picks:fortune_diamond",
	recipe = {
		{"default:goldblock", "default:mese", "default:goldblock"},
		{"default:bronzeblock", "default:diamond", "default:bronzeblock"},
		{"default:steelblock", "default:mese", "default:steelblock"},
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

minetest.register_tool("special_picks:big_diamondpick", {
	description = "big diamond pick",
	inventory_image = "big_diamondpick.png",
	tool_capabilities = {
		full_punch_interval = 0.9,
		max_drop_level=3,
		groupcaps={
			cracky = {times={[1]=2.0, [2]=1.0, [3]=0.50}, uses=270, maxlevel=3}
		},
		damage_groups = {fleshy=5},
	},
})

minetest.register_craft({
	output = "special_picks:big_diamondpick",
	recipe = {
		{"default:diamondblock", "default:diamondblock", "default:diamondblock"},
		{"", "default:tree", ""},
		{"", "default:tree", ""},
	}
})

--battle pick

minetest.register_tool("special_picks:battle_pick", {
	description = "battle pick",
	inventory_image = "default_tool_diamondpick.png",
	tool_capabilities = {
		full_punch_interval = 0.9,
		max_drop_level=3,
		groupcaps={
			cracky = {times={[1]=2.0, [2]=1.0, [3]=0.50}, uses=30, maxlevel=3}
		},
		damage_groups = {fleshy=10},
	},
})

minetest.register_craftitem("special_picks:abrasive_paper", {
	description = "abrasive paper",
	inventory_image = "default_paper.png",
})

minetest.register_craft({
	output = "special_picks:abrasive_paper",
	recipe = {
		{"default:sandstone", "default:sandstone", "default:sandstone"},
		{"default:paper", "default:paper", "default:paper"},
	}
})







