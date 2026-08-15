local json = require "lib.dkjson"
local save = {}

---reads file from external .json file
---@param file string -- only the name of the .json file
---@return table | string | number | boolean | nil
function save.readjson(file)
    local file, msg = love.filesystem.read(file .. ".json")

    -- oh boy
    if type(file) ~= "nil" then
        local obj, _, err = json.decode(file)
        if err then
            print("invalid .json file: " .. err)
            return {}
        else
            return obj
        end
    else
        print("error reading .json file: " .. tostring(msg))
        return {}
    end
end

---writes lua table to a .json file
---@param name string -- only the name of the .json file
---@param obj table | string | number | boolean | nil
---@return boolean
function save.writejson(name, obj)
    local sucess, message = love.filesystem.write(name .. ".json", tostring(json.encode(obj, { indent = true })))
    if not sucess then
        print("! failed to save (" .. message .. ") !")
    else
        print("- finished saving (" .. tostring(name) .. ".json) -")
    end
    return sucess
end

return save
