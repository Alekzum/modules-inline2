loggerEnabled = false

local function demoCommand(_, query)
    local args = query:getArgs() -- аргументы
    query:answer("Вызов команды с аргументами (" .. args .. ")")
end

local function toggleLogger(_, query)
    loggerEnabled = ~loggerEnabled
    -- local args = query:getArgs() -- аргументы
    query:answer("Состояние логгера на изменения текста: " .. loggerEnabled)
end

local function logger(input)
    local text = inline:getText(input)
    inline:toast("Текст изменен в поле: " .. text)
end

return function(module)
    module:registerCommand("izum:demo", demoCommand)
    module:registerCommand("izum:logger", toggleLogger)
    module:registerWatcher(logger, inline.TYPE_TEXT_CHANGED)
    inline:toast("модуль изюма включен")
end
