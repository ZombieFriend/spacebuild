-- Copyright (C) 2012-2013 Spacebuild Development Team
--
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program.  If not, see <http://www.gnu.org/licenses/>.

local GM = SPACEBUILD
local class = GM.class or {}
GM.class = class

local preload = true
local tostring = tostring
local error = error
local setmetatable = setmetatable
local pairs = pairs
local table = table

-- GMOD
local include = include
local file = file

local classes_folder = { "classes" }
local loadedclasses = {}

-- GMOD
local function getClassFolder(name)
	if preload then return "" end
	for k, v in pairs(classes_folder) do
		MsgN("Looking for:"..v .. name .. ".lua")
		if #file.Find(v .. name .. ".lua", "LUA") == 1 then
			return v
		end
	end
	return false
end

-- GMOD
local function openClass(name)
	include(getClassFolder(name) .. name .. ".lua")
end


function class.exists(name)
	return loadedclasses[name] or getClassFolder(name) ~= false
end

function class.new(name, a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s, t, u, v, w, x, y, z)
	name = tostring(name)
	if not loadedclasses[name] then
		if not class.exists(name) then
			error("Class " .. name .. " not found")
		end
		local class = {
			classLoader : class
		}
		class.__index = class
		CLASS = class
		openClass(name)
		CLASS = nil
		function class:getClass()
			return name
		end

		loadedclasses[name] = function(a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s, t, u, v, w, x, y, z)
			local tmp = {}
			setmetatable(tmp, class)
			tmp:init(a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s, t, u, v, w, x, y, z)
			return tmp
		end
	end
	if not preload then
		return loadedclasses[name](a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s, t, u, v, w, x, y, z)
	end
end

function class.registerClassPath(path)
	table.insert(classes_folder, path)
end

-- PreLoad
class.new("rd/ResourceRegistry")
class.new("rd/Resource")
class.new("rd/ResourceContainer")
class.new("rd/ResourceEntity")
class.new("rd/ResourceInfo")
class.new("rd/ResourceNetwork")
class.new("ls/PlayerSuit")
class.new("sb/BaseEnvironment")
class.new("sb/SunEnvironment")
class.new("sb/LegacyBloomInfo")
class.new("sb/LegacyColorInfo")
class.new("sb/LegacyPlanet")
class.new("sb/SpaceEnvironment")
class.new("ui/BottomLeftPanel")
class.new("ui/BottomRightPanel")
class.new("ui/HudBarIndicator")
class.new("ui/HudBarTextIndicator")
class.new("ui/HudComponent")
class.new("ui/HudPanel")
class.new("ui/TextElement")
class.new("ui/TopLeftPanel")
class.new("ui/TopRightPanel")

preload = false
