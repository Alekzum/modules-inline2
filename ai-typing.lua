---@meta ai-typing
-- using [VSCode with Lua extension](https://luals.github.io/)

-- неизвестно, по возможности - не трогать
---@alias LuaValue any
---@alias LoadedModules { [string]: Module } -- dictionary: filepath -> Module
---@alias CommandsMap { [string]: Command } -- dictionary: name -> Command
---@alias WatchersMap table<LuaValue, integer> -- map of watcher -> mask
---@alias PreferencesMap { [string]: PreferencesItem[] } -- category -> list of PreferencesItem
---@alias CommandFinders LuaValue[] -- array of finder functions/values

---@class (exact) AccessibilityNodeInfo

-- Объект запроса
---@class (exact) Query
---@field getText fun(this: Query): string # Получить текущую строку поля ввода.
---@field getExpression fun(this: Query): string # Получить строку выражения вызова команды.
---@field getArgs fun(this: Query): string # Получить строку аргумента команды.
---@field getAccessibilityNodeInfo fun(this: Query): AccessibilityNodeInfo # AccessibilityNodeInfo - Получить информацию о ноде поля ввода.
---@field replaceExpression fun(this: Query, string): string # Возвращает полную исходную строку поля ввода, где выражение вызова команды (expression) заменено на replacementText. Важно: Этот метод не изменяет поле ввода сам по себе, он лишь возвращает измененную строку.
---@field answer fun(this: Query, text: string | ""): string # Устанавливает текст в поле ввода заместо вызова команды.

-- Инструменты работы с полями ввода
---@class (exact) Inline
---@field setText fun(this: Inline, node: AccessibilityNodeInfo, text: string): string|nil # Устанавливает текст в переданной AccessibilityNodeInfo. (заметка @alekzum: Возвращаемое значение неизвестно, мб `string` по подобию `inline:answer`, мб `nil` по иной логике)
---@field getText fun(this: Inline, node: AccessibilityNodeInfo): string # Получить текст из переданной AccessibilityNodeInfo
---@field setSelection fun(this: Inline, start: integer, end: integer): nil # Устанавливает позицию курсора в переданной AccessibilityNodeInfo
---@field cut fun(this: Inline, node: AccessibilityNodeInfo): nil # Вырезает текст в буфер обмена в переданной AccessibilityNodeInfo.
---@field copy fun(this: Inline, node: AccessibilityNodeInfo): nil # Копирует текст в буфер обмена в переданной AccessibilityNodeInfo.
---@field paste fun(this: Inline, node: AccessibilityNodeInfo): nil # Вставляет текст из буфера обмена в переданной AccessibilityNodeInfo.
---@field insertText fun(this: Inline, node: AccessibilityNodeInfo, text: string): nil # Вставить текст заместо курсора в переданной AccessibilityNodeInfo.
-- Прочее
---@field toast fun(this: Inline, string: string): nil # Выводит сообщение на экран пользователю
---@field timerTask fun(this: Inline, function: function): nil # Создает объект java.util.TimerTask из Lua-функции.
---@field getTimer fun(this: Inline): nil # Возвращает java.util.Timer для планирования задач TimerTask.
---@field getSharedPreferences fun(this: Inline, name: string): nil # Возвращает SharedPreferences по названию.
---@field getDefaultSharedPreferences fun(this: Inline): nil # Возвращает SharedPreferences по умолчанию.
---@field getLoadedModules fun(this: Inline): LoadedModules # Возвращает загруженные модули (ключ — путь к файлу, значение — объект Module).
---@field getAllCommands fun(this: Inline): CommandsMap # Возвращает все зарегистрированные команды (ключ — имя команды).
---@field getAllWatchers fun(this: Inline): WatchersMap # Возвращает всех зарегистрированных наблюдателей (ключ — функция, значение — маска событий).
---@field getAllPreferences fun(this: Inline): PreferencesMap # Возвращает все зарегистрированные предпочтения (ключ — категория).
---@field getAllCommandFinders fun(this: Inline): CommandFinders # Возвращает все зарегистрированные функции поиска команд.

---@class (exact) Module
---@field setCategory fun(this: Module, name: string): nil
---@field getCategory fun(this: Module): string
---@field getFilepath fun(this: Module): string
---@field registerCommand fun(this: Module, name: string, callback: fun(module: Module, query: Query), description: string?): nil
---@field registerWatcher fun(this: Module, callback: fun(...: any), mask: integer?): nil
---@field registerCommandFinder fun(this: Module, callback: fun(queryText: string): boolean): nil
---@field registerPreferences fun(this: Module, sharedPreferencesOrCallback: SharedPreferences|fun(builder: Builder): any, callback: (fun(builder: Builder): any)?): nil
---@field unregisterCommand fun(this: Module, name: string): nil
---@field unregisterWatcher fun(this: Module, callback: fun(...: any)): nil
---@field unregisterCommandFinder fun(this: Module, callback: fun(queryText: string): boolean): nil
---@field unload fun(this: Module): nil
---@field saveLazyLoad fun(this: Module): nil

---@class (exact) Command

---@class (exact) SharedPreferences
---@field getBoolean fun(this: SharedPreferences, key: string, defaultValue: boolean): boolean
---@field getString fun(this: SharedPreferences, key: string, defaultValue: string): string
---@field getInt fun(this: SharedPreferences, key: string, defaultValue: integer): integer
---@field getLong fun(this: SharedPreferences, key: string, defaultValue: integer): integer
---@field getFloat fun(this: SharedPreferences, key: string, defaultValue: number): number

---@class (exact) PreferencesItem

---@class (exact) Builder
---@field create fun(this: Builder, title: string, sharedPreferences: SharedPreferences?, ...: any): nil
---@field cancel fun(this: Builder): nil
---@field button fun(this: Builder, text: string, listener: function?): Button
---@field checkBox fun(this: Builder, sharedKeyOrText: string, textOrListener: string|function?): CheckBox
---@field slider fun(this: Builder, sharedKeyOrListener: string|function, max: integer?): Slider
---@field spinner fun(this: Builder, sharedKeyOrChoices: string|table, choicesOrListener: table|function?): Spinner
---@field text fun(this: Builder, text: string): Text
---@field smallButton fun(this: Builder, text: string, listener: function?): SmallButton
---@field textInput fun(this: Builder, sharedKeyOrHint: string, hintOrListener: string|function?): TextInput
---@field column fun(this: Builder, views: table): Column
---@field row fun(this: Builder, views: table): Row
---@field spacer fun(this: Builder, padding: integer): Spacer
---@field flexSpacer fun(this: Builder, weight: number?): FlexSpacer
---@field divider fun(this: Builder): Divider
---@field card fun(this: Builder, views: table): Card
---@field switch fun(this: Builder, sharedKeyOrText: string, textOrListener: string|function?): Switch
---@field vscroll fun(this: Builder, view: any): VScrollView
---@field hscroll fun(this: Builder, view: any): HScrollView

---@class (exact) View
---@class (exact) Button: View
---@field setListener fun(this: Button, listener: function): Button
---@class (exact) CheckBox: View
---@field setListener fun(this: CheckBox, listener: function): CheckBox
---@field setSharedKey fun(this: CheckBox, key: string): CheckBox
---@field setDefault fun(this: CheckBox, value: boolean): CheckBox
---@class (exact) Slider: View
---@field setStep fun(this: Slider, step: number): Slider
---@field setOnStopTracking fun(this: Slider, listener: function): Slider
---@field setOnProgressChanged fun(this: Slider, listener: function): Slider
---@field setSharedKey fun(this: Slider, key: string): Slider
---@field setDefault fun(this: Slider, value: number): Slider
---@field useInt fun(this: Slider): Slider
---@class (exact) Spinner: View
---@field setListener fun(this: Spinner, listener: function): Spinner
---@field setSharedKey fun(this: Spinner, key: string): Spinner
---@class (exact) Text: View
---@class (exact) SmallButton: View
---@field setListener fun(this: SmallButton, listener: function): SmallButton
---@class (exact) TextInput: View
---@field setListener fun(this: TextInput, listener: function): TextInput
---@field setSharedKey fun(this: TextInput, key: string): TextInput
---@field setDefault fun(this: TextInput, value: string|number): TextInput
---@field setSingleLine fun(this: TextInput, value: boolean): TextInput
---@field hidePassword fun(this: TextInput): TextInput
---@field showPassword fun(this: TextInput): TextInput
---@field setInputType fun(this: TextInput, inputType: table): TextInput
---@field useFloat fun(this: TextInput): TextInput
---@field useInt fun(this: TextInput): TextInput
---@field useLong fun(this: TextInput): TextInput
---@class (exact) Column: View
---@class (exact) Row: View
---@class (exact) Spacer: View
---@class (exact) FlexSpacer: View
---@class (exact) Divider: View
---@class (exact) Card: View
---@field setCornerRadius fun(this: Card, radius: number): Card
---@field setCardBackgroundColor fun(this: Card, color: integer): Card
---@field setStrokeColor fun(this: Card, color: integer): Card
---@field setStrokeWidth fun(this: Card, width: number): Card
---@field setCardElevation fun(this: Card, elevation: number): Card
---@class (exact) Switch: View
---@field setListener fun(this: Switch, listener: function): Switch
---@field setSharedKey fun(this: Switch, key: string): Switch
---@field setDefault fun(this: Switch, value: boolean): Switch
---@class (exact) VScrollView: View
---@class (exact) HScrollView: View

---@class (exact) FloatingWindow
---@field close fun(this: FloatingWindow): nil
---@field isFocused fun(this: FloatingWindow): boolean
---@field layout View
---@field windowManager any


---@class Rect
---@field left integer
---@field top integer
---@field right integer
---@field bottom integer

---@class WindowManager

---@class (exact) Windows
---@field create fun(this: Windows, config: { [string]: any }?, builderFunction: fun(ui: any): any): FloatingWindow
---@field createAligned fun(this: Windows, node: AccessibilityNodeInfo, config: { [string]: any }?, builderFunction: fun(ui: any): any): FloatingWindow
---@field getBoundsInScreen fun(this: Windows, node: AccessibilityNodeInfo): Rect
---@field getScreenWidth fun(this: Windows): integer
---@field getScreenHeight fun(this: Windows): integer
---@field isSupported fun(this: Windows): boolean
---@field insertText fun(this: Windows, text: string): AccessibilityNodeInfo|false
---@field supportInsert fun(this: Windows): nil
---@field isInsertAvailable fun(this: Windows): boolean
---@field getLastNode fun(this: Windows): AccessibilityNodeInfo|nil
---@field getLastText fun(this: Windows): string|nil
---@field getLastPackage fun(this: Windows): string|nil
---@field closeAll fun(this: Windows): nil

---@class MenuItem
---@field caption string
---@field action fun(this: MenuItem, module: any, query: Query): any

---@class (exact) Menu
---@field create fun(this: Menu, query: Query, items: (string|MenuItem)[], cancelAction: (fun(): any)?): nil

---@class (exact) HTTPResponse
---@field code integer
---@field body string
---@field headers table

---@class (exact) HTTP
---@field newBuilder fun(this: HTTP): any
---@field buildUrl fun(this: HTTP, url: string, params: table?): any
---@field buildFormBody fun(this: HTTP, data: table): any
---@field buildMultipartBody fun(this: HTTP, data: table): any
---@field buildBody fun(this: HTTP, data: string|table, mediaType: string?): any
---@field buildHeaders fun(this: HTTP, headers: table): table
---@field buildRequest fun(this: HTTP, req: table): any
---@field post fun(this: HTTP, req: table, onResponse: (fun(call: any, response: HTTPResponse, body: string))?, onFailure: (fun(call: any, exception: any))?): nil
---@field get fun(this: HTTP, req: table, onResponse: (fun(call: any, response: HTTPResponse, body: string))?, onFailure: (fun(call: any, exception: any))?): nil
---@field patch fun(this: HTTP, req: table, onResponse: (fun(call: any, response: HTTPResponse, body: string))?, onFailure: (fun(call: any, exception: any))?): nil
---@field delete fun(this: HTTP, req: table, onResponse: (fun(call: any, response: HTTPResponse, body: string))?, onFailure: (fun(call: any, exception: any))?): nil
---@field put fun(this: HTTP, req: table, onResponse: (fun(call: any, response: HTTPResponse, body: string))?, onFailure: (fun(call: any, exception: any))?): nil
---@field call fun(this: HTTP, request: any, onResponse: (fun(call: any, response: HTTPResponse, body: string))?, onFailure: (fun(call: any, exception: any))?): nil

---@class (exact) Utils
---@field split fun(this: Utils, s: string, pattern: string, limit: integer?): string[]
---@field escape fun(this: Utils, s: string): string
---@field parseArgs fun(this: Utils, s: string): string[]
---@field command fun(this: Utils, command: string, count: integer?, error: string?): fun(...: any)
---@field hasArgs fun(this: Utils, command: function, error: string?): function
---@field mapEntries fun(this: Utils, javaMap: any): fun(): (any, any)
---@field listValues fun(this: Utils, collection: any): fun(): any
---@field map fun(this: Utils, t: table, fn: fun(value: any, key: any): any): table
---@field filter fun(this: Utils, t: table, fn: fun(value: any, key: any): boolean): table
---@field keys fun(this: Utils, t: table): any[]
---@field trim fun(this: Utils, s: string): string
---@field startsWith fun(this: Utils, s: string, prefix: string): boolean
---@field endsWith fun(this: Utils, s: string, suffix: string): boolean

---@class (exact) IUTF8
---@field charpattern string
---@field len fun(this: IUTF8, s: string): integer
---@field sub fun(this: IUTF8, s: string, start: integer, finish: integer?): string
---@field char fun(this: IUTF8, ...: integer): string
---@field isLower fun(this: IUTF8, s: string): boolean
---@field isUpper fun(this: IUTF8, s: string): boolean

---@class (exact) JSON
---@field emptyObject any
---@field null any
---@field dump fun(this: JSON, tbl: table): string
---@field load fun(this: JSON, s: string): table
---@field dumpObject fun(this: JSON, tbl: table): any
---@field loadObject fun(this: JSON, obj: any): table

---@class (exact) ColoramaQuery
---@field answer fun(this: ColoramaQuery, text: string): string

---@class (exact) Colorama
---@field newline string
---@field wrap fun(this: Colorama, command: fun(...: any)): fun(...: any)
---@field of fun(this: Colorama, query: Query): ColoramaQuery
---@field quote fun(this: Colorama, text: string): string
---@field font fun(this: Colorama, text: string, color: string): string
---@field text fun(this: Colorama, sep: string, ...: string): string
---@field bold fun(this: Colorama, text: string): string
---@field italic fun(this: Colorama, text: string): string
---@field small fun(this: Colorama, text: string): string
---@field big fun(this: Colorama, text: string): string
---@field strike fun(this: Colorama, text: string): string
---@field subscript fun(this: Colorama, text: string): string
---@field pre fun(this: Colorama, text: string): string
---@field h1 fun(this: Colorama, text: string): string
---@field h2 fun(this: Colorama, text: string): string
---@field h3 fun(this: Colorama, text: string): string
---@field h4 fun(this: Colorama, text: string): string
---@field h5 fun(this: Colorama, text: string): string
---@field h6 fun(this: Colorama, text: string): string

-- Объект запроса
-- Позволяет выводить результат выполнения команды, а также хранит аргументы и текст поля ввода.

-- local function democmd(_, query)
--     local args = query:getArgs() -- аргумент
--     query:answer("Вызов команды с аргументом " .. args)
-- end

-- return function(module)
--     module:registerCommand("demo", democmd)
-- end
-- Методы объекта запроса
-- query:getText() -> string - Получить текущую строку поля ввода.
-- query:getExpression() -> string - Получить строку выражения вызова команды.
-- query:getArgs() -> string - Получить строку аргумента команды.
-- query:getAccessibilityNodeInfo() -> AccessibilityNodeInfo - Получить информацию о ноде поля ввода.
-- query:replaceExpression(string) -> string - Возвращает полную исходную строку поля ввода, где выражение вызова команды (expression) заменено на replacementText. Важно: Этот метод не изменяет поле ввода сам по себе, он лишь возвращает измененную строку.
-- query:answer(text = "") - Устанавливает текст в поле ввода заместо вызова команды.

-- Инструменты работы с полями ввода
-- inline:setText(node, text) - Устанавливает текст в переданной AccessibilityNodeInfo.
-- inline:getText(node) - Получить текст из переданной AccessibilityNodeInfo.
-- inline:setSelection(node, start, end) - Устанавливает позицию курсора в переданной AccessibilityNodeInfo.
-- inline:cut(node) - Вырезает текст в буфер обмена в переданной AccessibilityNodeInfo.
-- inline:copy(node) - Копирует текст в буфер обмена в переданной AccessibilityNodeInfo.
-- inline:paste(node) - Вставляет текст из буфера обмена в переданной AccessibilityNodeInfo.
-- inline:insertText(node, text) - Вставить текст заместо курсора в переданной AccessibilityNodeInfo.
-- -- Прочее
-- inline:toast(string) - Выводит сообщение на экран пользователю.
-- inline:timerTask(function) - Создает объект java.util.TimerTask из Lua-функции.
-- inline:getTimer() -> Timer - Возвращает java.util.Timer для планирования задач TimerTask.
-- inline:getSharedPreferences(name) - Возвращает SharedPreferences по названию.
-- inline:getDefaultSharedPreferences() - Возвращает SharedPreferences по умолчанию.
-- inline:getLoadedModules() -> HashMap<String, Module> - Возвращает загруженные модули (ключ — путь к файлу, значение — объект Module).
-- inline:getAllCommands() -> HashMap<String, Command> - Возвращает все зарегистрированные команды (ключ — имя команды).
-- inline:getAllWatchers() -> HashMap<LuaValue, Int> - Возвращает всех зарегистрированных наблюдателей (ключ — функция, значение — маска событий).
-- inline:getAllPreferences() -> HashMap<String, HashSet<PreferencesItem>> - Возвращает все зарегистрированные предпочтения (ключ — категория).
-- inline:getAllCommandFinders() -> HashSet<LuaValue> - Возвращает все зарегистрированные функции поиска команд.

-- Методы модулей
-- module:setCategory(name) - Указывает категорию, которая будет применяться к следующим регистрациям команд и предпочтений.
-- module:getCategory() -> string - Получить текущее название категории.
-- module:getFilepath() -> string - Получить путь к модулю.
-- module:registerCommand(name, function [, description]) - Регистрирует новую команду (см. раздел "Команды").
-- module:registerWatcher(function, mask = inline.TYPE_TEXT_CHANGED) - Регистрирует новый наблюдатель для указанного типа событий (см. раздел "Наблюдатели").
-- module:registerCommandFinder(function) - Регистрирует поиск команд.
-- module:registerPreferences(sharedPreferences, function) - Регистрирует каталог предпочтений с указанными SharedPreferences.
-- module:registerPreferences(function) - Регистрирует каталог предпочтений.
-- module:unregisterCommand(name) - Отменяет регистрацию команды по имени. Полезно для динамического управления командами модуля.
-- module:unregisterWatcher(function) - Отменяет регистрацию наблюдателя (требуется ссылка на ту же функцию, что была передана при регистрации).
-- module:unregisterCommandFinder(function) - Отменяет регистрацию поиска команд по функции.
-- module:unload() - Отменяет регистрации модуля.
-- module:saveLazyLoad() - Сохраняет кэш ленивой загрузки, позволяет загрузить модуль только при вызове одной из команд модуля.
-- Предпочтения пользователя
-- Inline позволяет создавать два типа UI: страницы настроек (Предпочтения) и Плавающие окна. Оба используют один и тот же набор элементов интерфейса, создаваемых через таблицу-строитель.

-- local prefs = inline:getDefaultSharedPreferences()

-- local function getPreferences(builder)
--     return {
--         builder.checkBox("my_module_enabled", "Включить фичу X"):setDefault(true),
--         builder.textInput("user_api_key", "API Ключ пользователя"),
--         builder.slider("update_interval", 100):setDefault(30) -- Пример со Slider
--     }
-- end

-- return function(module)
--     module:setCategory "Мой Супер Модуль"
--     module:registerPreferences(getPreferences)
--      -- Пример чтения настройки в команде
--     module:registerCommand("doFeatureX", function(_, query)
--         local isEnabled = prefs:getBoolean("my_module_enabled", true) -- Читаем значение
--         if isEnabled then
--             local apiKey = prefs:getString("user_api_key", "")
--             query:answer("Фича X включена! API Ключ: " .. apiKey)
--         else
--             query:answer "Фича X отключена в настройках."
--         end
--     end, "Выполнить фичу X, если включена")
-- end
-- Методы для диалога предпочтений
-- builder:create(title, [sharedPreferences], builders...) - Создает новый диалог предпочтений.
-- builder:cancel() - Закрыть текущий диалог предпочтений.
-- Плавающие окна
-- Позволяют отображать кастомный UI поверх других приложений. Используются для интерактивных инструментов, панелей быстрого доступа и т.д.

-- require "windows"

-- windows.create({ noLimits = true }, function(ui)
--     return {
--         "Text",
--         {
--             ui.button("Info", function()
--             end),
--             ui.spacer(8),
--             ui.button("Close", function()
--                ui:close()
--             end)
--          }
--     }
-- end)
-- windows.getBoundsInScreen(node) -> Rect - Получить положение на экране переданной AccessibilityNodeInfo.
-- windows.getScreenWidth() -> Int - Получить ширину экрана.
-- windows.getScreenHeight() -> Int - Получить высоту экрана.
-- windows.isSupported() -> boolean - Возвращает булево значение, указывающее на поддержку плавающих окон.
-- windows.insertText() -> AccessibilityNodeInfo | false - Вставляет текст после курсора в последней ноде с которой взаимодействовал пользователь и возвращает AccessibilityNodeInfo. Если нода отсутствует или текущий фокус на окне то возвращает false.
-- windows.supportInsert() - Включает поддержку вставки текста. Единожды
-- windows.isInsertAvailable() -> boolean - Проверяет доступность вставки текста.
-- windows.getLastNode() -> AccessibilityNodeInfo | nil - Возвращает последнюю отслеживаемую ноду поля ввода.
-- windows.getLastText() -> string | nil - Возвращает текст последнего отслеживаемого поля ввода.
-- windows.getLastPackage() -> string | nil - Возвращает имя пакета приложения, которому принадлежит последнее поле.
-- windows.closeAll() - Закрывает все активные плавающие окна.
-- windows.create(config, builderFunction) -> FloatingWindow - Создает плавающее окно с указанной таблицей конфигурации и функции возвращающая предпочтения.
-- windows.createAligned(node, config, builderFunction) -> FloatingWindow - Создает плавающее окно над переданной AccessibilityNodeInfo.
-- Настройки плавающего окна
-- autoFocus = true - Автофокус на элементах ввода в окне, разфокусировка при клике вне окна.
-- cornerRadius = 16 - Радиус скругления углов окна (в dp).
-- paddingLeft, paddingTop, paddingRight, paddingBottom - Внутренние отступы окна (в dp).
-- noLimits = false - Может ли окно выходить за пределы экрана.
-- noBackground = false - Окно без фона.
-- allowTouchMove = true - Позволяет перетаскивать окно пальцем.
-- positionX = 0 - Позиция X окна в пикселях.
-- positionY = 0 - Позиция Y окна в пикселях.
-- offsetX = 0 - Отступ по X окна в dp относительно позиции AccessibilityNodeInfo.
-- offsetY = 0 - Отступ по Y окна в dp относительно позиции AccessibilityNodeInfo.
-- align = "right" | "left" - Гравитация у окна созданного над AccessibilityNodeInfo.
-- gravity = gravityInt - Гравитация окна.
-- backgroundColor = ARGBInt - Цвет фона окна (по умолчанию - в зависимости от темы).
-- sharedPreferences = prefs - Объект SharedPreferences для элементов окна (по умолчанию - SharedPreferences по умолчанию).
-- Функции обратного вызова (продублируется в таблице конструктора):

-- onFocusChanged = nil - При изменении фокуса окна при автофокусе.
-- onMove = nil - При перемещении окна.
-- onClose = nil - При закрытии окна.
-- Поля плавающего окна
-- Внутри builderFunction плавающего окна

-- ui:close() - Закрыть окно.
-- ui:isFocused() -> boolean - Возвращает состояние автофокуса.
-- ui.layout -> View - Родительский элемент окна.
-- ui.windowManager -> WindowManager - WindowManager.
-- Элементы интерфейса
-- Для создания предпочтений и пользовательского интерфейса, передается таблица Builder, предоставляющий методы для создания различных элементов интерфейса.

-- Button
-- Унаследован от MaterialButton

-- builder.button(text, function) - Конструктор с слушателем.

-- builder.button(text) - Конструктор.

-- button:setListener(function) - Установить слушатель кнопки, возвращает себя.

-- CheckBox
-- Унаследован от MaterialCheckBox

-- builder.checkBox(sharedKey, text) - Конструктор.

-- builder.checkBox(text, function) - Конструктор с слушателем.

-- builder.checkBox(text) - Конструктор.

-- checkBox:setListener(function) - Установить слушатель, возвращает себя.

-- checkBox:setSharedKey(string) - Установить ключ предпочтения, возвращает себя.

-- checkBox:setDefault(boolean) - Установить значение по умолчанию, возвращает себя.

-- Slider
-- Унаследован от MaterialSlider

-- builder.seekBar остаётся как алиас для обратной совместимости.

-- builder.slider(sharedKey, max) - Конструктор с указанием максимального значения.

-- builder.slider(onStopTracking, max) - Конструктор с слушателем.

-- builder.slider(onStopTracking) - Конструктор с слушателем.

-- slider:setStep(number) - Установить шаг, возвращает себя.

-- slider:setOnStopTracking(function) - Установить слушатель остановки перемещения ползунка, возвращает себя.

-- slider:setOnProgressChanged(function) - Установить слушатель изменения прогресса, возвращает себя.

-- slider:setSharedKey(string) - Установить ключ предпочтения, возвращает себя.

-- slider:setDefault(number) - Установить значение по умолчанию, возвращает себя.

-- slider:useInt() - Использовать целые числа вместо float, возвращает себя.

-- Spinner
-- Унаследован от AppCompatSpinner

-- builder.spinner(sharedKey, choices) - Конструктор с указанием ключа предпочтения и списка вариантов.

-- builder.spinner(choices, listener) - Конструктор с указанием списка вариантов и слушателя.

-- spinner:setListener(function) - Установить слушатель выбора, возвращает себя.

-- spinner:setSharedKey(string) - Установить ключ предпочтения, возвращает себя.

-- Text
-- Унаследован от AppCompatTextView

-- builder.text(text) - Конструктор с указанием текста для отображения.
-- "Text" - Строка в Lua также интерпретируется как текстовый элемент.
-- SmallButton
-- Унаследован от MaterialButton

-- builder.smallButton(text, function) - Конструктор с слушателем.

-- builder.smallButton(text) - Конструктор.

-- smallButton:setListener(function) - Установить слушатель кнопки, возвращает себя.

-- TextInput
-- Унаследован от TextInputLayout

-- builder.textInput(sharedKey, hint) - Конструктор с указанием ключа предпочтения и подсказки.

-- builder.textInput(hint, listener) - Конструктор с указанием подсказки и слушателя.

-- builder.textInput(hint) - Конструктор с указанием только подсказки.

-- textInput:setListener(function) - Установить слушатель ввода, возвращает себя.

-- textInput:setSharedKey(string) - Установить ключ предпочтения, возвращает себя.

-- textInput:setDefault(string) - Установить значение по умолчанию, возвращает себя.

-- textInput:setDefault(number) - Установить значение по умолчанию, возвращает себя.

-- textInput:setSingleLine(boolean) - Установить однострочный режим, возвращает себя.

-- textInput:hidePassword() - Скрыть пароль, возвращает себя.

-- textInput:showPassword() - Отменить скрытие, возвращает себя.

-- textInput:setInputType(table) - Установить тип ввода, таблица состоит из названия полей в android.text.InputType, возвращает себя.

-- textInput:useFloat() - Использовать float, возвращает себя.

-- textInput:useInt() - Использовать int, возвращает себя.

-- textInput:useLong() - Использовать long, возвращает себя.

-- Column
-- Унаследован от LinearLayout

-- builder.column(views) - Конструктор для создания вертикальной колонки, принимающий таблицу views, содержащую элементы интерфейса.
-- {} (внутри Row или по умолчанию) - Создает колонку элементов, внутри строки элементов.
-- Row
-- Унаследован от LinearLayout

-- builder.row(views) - Конструктор для создания горизонтальной строки, принимающий таблицу views, содержащую элементы интерфейса.
-- {} (внутри Column) - Создает строку элементов, внутри колонки элементов.
-- Spacer
-- Унаследован от View

-- builder.spacer(padding) - Конструктор для создания элемента-прокладки с указанным значением отступа (padding).
-- FlexSpacer
-- Унаследован от View

-- Растягивающийся спейсер, заполняющий доступное пространство в LinearLayout с использованием layout weight.

-- builder.flexSpacer() - Конструктор с весом 1 по умолчанию.
-- builder.flexSpacer(weight) - Конструктор с указанным весом.
-- Divider
-- Унаследован от View

-- Тонкий разделитель, автоматически адаптирующий ориентацию в зависимости от родительского LinearLayout.

-- builder.divider() - Конструктор.
-- Card
-- Унаследован от MaterialCardView

-- Стилизованный контейнер с обводкой, скруглением и тенью для группировки элементов.

-- builder.card(views) - Конструктор, принимающий таблицу элементов.

-- card:setCornerRadius(number) - Установить радиус скругления углов (dp), возвращает себя.

-- card:setCardBackgroundColor(ARGBInt) - Установить цвет фона, возвращает себя.

-- card:setStrokeColor(ARGBInt) - Установить цвет обводки, возвращает себя.

-- card:setStrokeWidth(number) - Установить толщину обводки (dp), возвращает себя.

-- card:setCardElevation(number) - Установить высоту тени, возвращает себя.

-- Switch
-- Унаследован от MaterialSwitch

-- builder.switch(sharedKey, text) - Конструктор.

-- builder.switch(text, function) - Конструктор с слушателем.

-- builder.switch(text) - Конструктор.

-- switch:setListener(function) - Установить слушатель, возвращает себя.

-- switch:setSharedKey(string) - Установить ключ предпочтения, возвращает себя.

-- switch:setDefault(boolean) - Установить значение по умолчанию, возвращает себя.

-- VScrollView
-- Унаследован от ScrollView

-- builder.vscroll(view) - Конструктор для вертикальной прокрутки, принимающий элемент интерфейса.
-- HScrollView
-- Унаследован от HorizontalScrollView

-- builder.hscroll(view) - Конструктор для горизонтальной прокрутки, принимающий элемент интерфейса.
-- Текстовые меню
-- Встроенная библеотека menu позволяет создавать кликабельные интерактивные меню прямо в тексте.

-- require "menu"

-- local function showGreeting(_, query)
--     query:answer "Hello from the greeting menu!"
-- end

-- local function mainMenu(_, query)
--     local items = {
--         "Main Menu:\n",
--         { caption = "[Greet]", action = showGreeting },
--         " ",
--         { caption = "[Exit]", action = function(_, query) query:answer() end },
--     }
--     menu.create(query, items)
-- end

-- return function(module)
--     module:registerCommand("mainmenu", mainMenu, "Displays the main menu")
-- end
-- menu.create(query, items [, cancelAction]) - Создает текстовое меню и заменяет текст команды результатом.

-- query (object): Объект запроса (query) из Inline, представляющий текстовое поле, в котором вызывается меню. Меню заменяет текст команды, вызвавшей его.
-- items (table): Таблица, описывающая структуру меню. Каждый элемент таблицы может быть строкой (для простого текста) или таблицей (для интерактивного элемента меню).
-- cancelAction (function): Функция, которая будет вызвана, если меню будет прервано, по умолчанию удаление меню
-- Формат элементов items:

-- Строка: Отображает простой текст в меню.
-- Таблица: Представляет интерактивный элемент меню. Должна содержать следующие поля:
-- caption (string): Текст, отображаемый для этого элемента меню.
-- action (function): Функция, которая будет вызвана, когда пользователь выберет этот элемент меню. Функция должна принимать объект query.
-- Встроенные библиотеки
-- Импорт происходит с помощью функции require.

-- colorama
-- Инструмент для форматирования текста с использованием HTML-подобных тегов.

-- require "colorama"

-- local function hellocmd(_, query)
--   -- Форматируем вывод с использованием colorama
--   local formattedText = colorama.bold("Привет, ") .. colorama.italic("мир") .. colorama.font("!", "red")

--   -- Отправляем отформатированный текст в поле ввода
--   query:answer(formattedText)
-- end

-- return function(module)
--   module:registerCommand("hello_colored", colorama.wrap(hellocmd), "Prints a formatted hello world message.")
-- end
-- colorama.newline -> string - Строка для переноса (<br>).
-- colorama.wrap(command) -> function - Оборачивает функцию команды для поддержки форматированного вывода через coloramaQuery.
-- colorama.of(query) -> ColoramaQuery - Возвращает специальный объект coloramaQuery для форматированного ответа.
-- colorama.quote(text) -> string - Экранирует специальные HTML символы в тексте.
-- colorama.font(text, color) -> string - Оборачивает текст в тег <font color="...">.
-- colorama.text(sep, text...) -> string - Объединяет строки text через разделитель sep.
-- colorama.bold(text) -> string - Оборачивает текст в тег <b>.
-- colorama.italic(text) -> string - Оборачивает текст в тег <i>.
-- colorama.small(text) -> string - Оборачивает текст в тег <small>.
-- colorama.big(text) -> string - Оборачивает текст в тег <big>.
-- colorama.strike(text) -> string - Оборачивает текст в тег <strike>.
-- colorama.subscript(text) -> string - Оборачивает текст в тег <sub>.
-- colorama.pre(text) -> string - Оборачивает текст в тег <pre>.
-- colorama.h1(text) -> string - Оборачивает текст в тег <h1>.
-- colorama.h2(text) -> string - Оборачивает текст в тег <h2>.
-- colorama.h3(text) -> string - Оборачивает текст в тег <h3>.
-- colorama.h4(text) -> string - Оборачивает текст в тег <h4>.
-- colorama.h5(text) -> string - Оборачивает текст в тег <h5>.
-- colorama.h6(text) -> string - Оборачивает текст в тег <h6>.
-- http
-- Библиотека для выполнения HTTP-запросов с использованием OkHttp3.

-- require "http"

-- client.post({
--         url = "https://your-api.example.com/endpoint",
--         json = { key1 = "value1", key2 = "value2" }
--     },
--     function(call, response, body)
--         print("Response: " .. body)
--     end,
--     function(call, exception)
--         print("Exception: " .. exception:getMessage())
--     end
-- )
-- http.Request -> userdata - Класс okhttp3.Request для создания запросов.

-- http(client) -> table - Возвращает новую таблицу http с указанным OkHttpClient.

-- http.buildUrl(url, params) -> okhttp3.HttpUrl - Строит объект okhttp3.HttpUrl из базового URL и таблицы GET-параметров.

-- http.buildFormBody(data) -> okhttp3.FormBody - Строит тело запроса okhttp3.FormBody из таблицы данных формы.

-- http.buildMultipartBody(data) -> okhttp3.MultipartBody - Строит составное тело запроса okhttp3.MultipartBody из таблицы частей.

-- http.buildBody(data, mediaType) -> okhttp3.RequestBody - Строит тело запроса okhttp3.RequestBody из строки и медиа-типа.

-- http.buildHeaders(table) -> okhttp3.Headers - Строит объект okhttp3.Headers из таблицы заголовков.

-- http.newBuilder() -> okhttp3.OkHttpClient - Возвращает новый OkHttpClient.Builder.

-- http.buildRequest(table) -> okhttp3.Request - Строит объект okhttp3.Request на основе переданной таблицы параметров.

-- Формат таблицы HTTP-запроса

-- url (string) - адрес
-- params (table) - Lua таблица параметров url
-- method (string) - адрес
-- json (string | table) - JSON строка или Lua таблица
-- body (string | table) - таблица FormData либо строка, в таком случае mediaType обязателен
-- http.post(table [, onResponse [, onFailure ] ]) - Выполняет HTTP-запрос с методом POST, сформированный из переданной таблицы параметров.

-- http.get(table [, onResponse [, onFailure ] ]) - Выполняет HTTP-запрос с методом GET, сформированный из переданной таблицы параметров.

-- http.patch(table [, onResponse [, onFailure ] ]) - Выполняет HTTP-запрос с методом PATCH, сформированный из переданной таблицы параметров.

-- http.delete(table [, onResponse [, onFailure ] ]) - Выполняет HTTP-запрос с методом DELETE, сформированный из переданной таблицы параметров.

-- http.put(table [, onResponse [, onFailure ] ]) - Выполняет HTTP-запрос с методом PUT, сформированный из переданной таблицы параметров.

-- http.call(request [, onResponse [, onFailure ] ]) - Выполняет HTTP запрос асинхронно, вызывая колбэки onResponse(call, response, bodyString) или onFailure(call, exception).

-- utils
-- Набор вспомогательных утилит.

-- require "utils"

-- local function addOne(node, query)
--   local num = tonumber(query:getArgs())

--   if num then
--     query:answer(tostring(num + 1))
--   else
--     query:answer "Invalid number"
--   end
-- end

-- return function(module)
--   module:registerCommand("addone", utils.hasArgs(addOne), "Adds 1 to a number")
-- end
-- utils.split(string, regex [, limit ]) -> table - Разделяет строку string по регулярному выражению regex на массив строк (не более limit частей).
-- utils.escape(string) -> string - Экранирует символы в строке, имеющие специальное значение в паттернах Lua.
-- utils.parseArgs(string) -> table - Разбирает строку на массив аргументов, используя правила, схожие с Unix shell (учитывает кавычки).
-- utils.command(command, count [, error]) -> function - Оборачивает команду с целью проверки количества аргументов, предварительно их разделив как в
-- utils.hasArgs(command [, error]) -> function - То же самое, что и utils.command, но деление на аргументы не происходит, проверяется наличие любого текста после имени команды. Если текст присутствует, вызывается command; иначе вызывается error (или стандартное сообщение об ошибке "Empty argument"). В command не передается таблица аргументов.
-- utils.mapEntries(javaMap) -> function - Возвращает итератор по записям Java Map. Каждый вызов итератора возвращает пару (key, value). Удобно для использования в цикле for.
-- utils.listValues(javaCollection) -> function - Возвращает итератор по элементам Java Collection/Iterable. Каждый вызов итератора возвращает следующий элемент.
-- utils.map(table, function) -> table - Применяет функцию к каждому элементу таблицы и возвращает новую таблицу с результатами. Функция принимает (value, key).
-- utils.filter(table, function) -> table - Фильтрует элементы таблицы, возвращая новую таблицу только с элементами, для которых функция вернула true. Функция принимает (value, key).
-- utils.keys(table) -> table - Возвращает таблицу-массив, содержащую все ключи переданной таблицы.
-- utils.trim(string) -> string - Удаляет пробельные символы в начале и конце строки.
-- utils.startsWith(string, prefix) -> boolean - Проверяет, начинается ли строка с указанного префикса.
-- utils.endsWith(string, suffix) -> boolean - Проверяет, заканчивается ли строка указанным суффиксом.


-- iutf8 (require 'iutf8')
-- Функции для корректной работы со строками в кодировке UTF-8.

-- utf8.charpattern -> string - Паттерн Lua, соответствующий одному символу UTF-8.
-- utf8.len(string) -> number - Возвращает количество символов (code points) в строке UTF-8.
-- utf8.sub(string, start [, end]) -> string - Возвращает подстроку строки UTF-8, используя индексы символов (start, end), а не байт.
-- utf8.char(...) -> string - Создает строку из последовательности кодов символов Unicode. Принимает переменное количество числовых аргументов, каждый из которых представляет собой код символа.
-- utf8.isLower(string) -> boolean - Проверяет, состоит ли строка только из символов в нижнем регистре (и не состоит только из символов в верхнем регистре).
-- utf8.isUpper(string) -> boolean - Проверяет, состоит ли строка только из символов в верхнем регистре (и не состоит только из символов в нижнем регистре).

-- json
-- Кодировщик и декодер JSON.
-- json.emptyObject -> userdata - Пустой JSON объект.
-- json.null -> userdata - JSON null.
-- json.dump(table) -> string - Сериализует Lua таблицу в JSON строку.
-- json.load(string) -> table - Десериализует JSON строку в Lua таблицу.
-- json.dumpObject(table) -> userdata - Сериализует Lua таблицу в JSON объект (JSONObject или JSONArray).
-- json.loadObject(object) -> table - Десериализует JSON объект (JSONObject или JSONArray) в Lua таблицу.
