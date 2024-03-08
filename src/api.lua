-- areas_jail/src/api.lua
-- API for jails
--[[
    areas_jail: Manage jails using area protection
    Copyright (C) 2024  1F616EMO

    This library is free software; you can redistribute it and/or
    modify it under the terms of the GNU Lesser General Public
    License as published by the Free Software Foundation; either
    version 2.1 of the License, or (at your option) any later version.

    This library is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
    Lesser General Public License for more details.

    You should have received a copy of the GNU Lesser General Public
    License along with this library; if not, write to the Free Software
    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
]]

local _aj = areas_jail
local _int = _aj.internal
local _data = _aj.jail_data
local logger = _int.logger:sublogger("api")

function _aj.set_jail(id, area_ids, spawnpoint)
    _data[id] = {
        areas = area_ids,
        spawnpoint = spawnpoint
    }
end

function _aj.unset_jail(id)
    _data[id] = nil
end

function _aj.is_in_areas(pos, area_ids)
    local area_ids_key = {}
    for _, area_id in ipairs(area_ids) do
        area_ids_key[area_id] = true
    end

    for area_id, _ in pairs(areas:getAreasAtPos(pos)) do
        if area_ids_key[area_id] then return true end
    end

    return false
end

function _aj.is_in_jail(pos, id)
    if not _data[id] then return false end

    return _aj.is_in_areas(pos, _data[id].areas)
end
