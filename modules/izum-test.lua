---@module 'typing'

---@type Module
local module

---@type Inline
local inline


loggerEnabled = false

--- @param query Query
local function removeThisModuleCommand(_, query)
    local args = query:getArgs() -- аргументы
    inline:toast("izum: Разружается модуль")
    module:unload()
end

--- @param query Query
local function demoCommand(_, query)
    local args = query:getArgs() -- аргументы
    query:answer("Вызов команды с аргументами (" .. args .. ")")
end

--- @param query Query
local function toggleLogger(_, query)
    loggerEnabled = ~loggerEnabled
    -- local args = query:getArgs() -- аргументы
    query:answer("Состояние логгера на изменения текста: " .. loggerEnabled)
end

local function logger(input)
    local text = inline:getText(input)
    inline:toast("izum: Текст изменен в поле: " .. text)
end

return function(module)
    module:registerCommand("izum:demo", demoCommand)
    module:registerCommand("izum:logger", toggleLogger)
    module:registerCommand("izum:fucku", removeThisModuleCommand)
    module:registerWatcher(logger, inline.TYPE_TEXT_CHANGED)
    inline:toast("izum: модуль загружен")
end
