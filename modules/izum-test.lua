---@module 'typing'
---@cast module Module
---@cast inline Inline


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
    loggerEnabled = 1 - loggerEnabled
    -- local args = query:getArgs() -- аргументы
    query:answer("Состояние логгера на изменения текста: " .. loggerEnabled)
end

local function logger(input)
    if loggerEnabled then
        local text = inline:getText(input)
        inline:toast("izum: Текст изменен в поле: " .. text)
    end
end

return function(module)
    module:registerCommand("izum:demo", demoCommand)
    module:registerCommand("izum:logger", toggleLogger)
    module:registerCommand("izum:fucku", removeThisModuleCommand)
    module:registerWatcher(logger, inline.TYPE_TEXT_CHANGED)
    inline:toast("izum: модуль загружен")
end
