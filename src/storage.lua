-- areas_jail/src/storage.lua
-- Handle data storage
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
local logger = _int.logger:sublogger("storage")

local serialize, deserialize = minetest.serialize, minetest.deserialize
local WP = minetest.get_worldpath()

local save_dir = WP .. "/areas_jail.lua"

-- Load save file
do
    local f, err = io.open(save_dir, "r")
    if f then
        local d = f:read("*a")
        _aj.jail_data = minetest.deserialize(d, true)
        if not _aj.jail_data then
            logger:warning(("Failed to load %s, using empty data."):format(
                save_dir
            ))
            _aj.jail_data = {}
        end
    else
        logger:warning(("Failed to open %s: \"%s\", using empty data."):format(
            save_dir, err
        ))
        _aj.jail_data = {}
    end
end

-- Save function
function _aj.save_data()
    logger:action("Saving jail data")
    local data = minetest.serialize(_aj.jail_data)
    minetest.safe_file_write(save_dir, data)
end

local function loop()
    _aj.save_data()
    minetest.after(60, loop)
end


minetest.after(60, loop)
minetest.register_on_shutdown(function()
    _aj.save_data()
end)
