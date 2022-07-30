Config = {}

--[[
──────────────────────────────────────────────────────────────────

	HealingPads (config.lua) - Created by Lama
	
	Support - Lama#9612 on Discord

──────────────────────────────────────────────────────────────────
]]--

-- set this to false if you don't want to use ND_Framework 
Config.UseND = true

-- sets the minimum and maximum price for healing
-- only works if UseND is set to true
Config.PriceMin = 50
Config.PriceMax = 550

-- healing pads locations
-- refer to this for the blips ids and colors https://docs.fivem.net/docs/game-references/blips/
Config.Blips = {{
    -- Central Los Santos Medical Center
    name = "Healing Pad",
    id = 153,
    x = 338.85,
    y = -1394.56,
    z = 31.55,
    color = 35
},{
    -- Mount Zonah Medical Center
    name = "Healing Pad",
    id = 153,
    x = -449.67,
    y = -340.83,
    z = 33.55,
    color = 35
}, {
    -- Pillbox Hill Medical Center
    name = "Healing Pad",
    id = 153,
    x = 356.70,
    y = -595.00,
    z = 27.85,
    color = 35
}, {
    -- Sandy Shores Medical Center
    name = "Healing Pad",
    id = 153,
    x = 1839.32,
    y = 3673.26,
    z = 33.30,
    color = 35
}, {
    -- Paleto Bay Care Center
    name = "Healing Pad",
    id = 153,
    x = -247.48,
    y = 6332.39,
    z = 31.50,
    color = 35
}}