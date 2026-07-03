---@module 'typing'
---@cast module Module
---@cast inline Inline


loggerEnabled = false

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

--- @param module Module
return function(module)
    module:setCategory("izum-test")
    module:registerCommand("izum:demo", demoCommand)
    module:registerCommand("izum:logger", toggleLogger)
    module:registerWatcher(logger, inline.TYPE_TEXT_CHANGED)
    inline:toast("izum: модуль загружен")
end
