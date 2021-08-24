ReadLater = {}

ReadLater.menu = hs.menubar.new()
ReadLater.menu:setIcon(hs.image.imageFromPath(os.getenv('HOME') .. '/.hammerspoon/read-later/book.png'))
ReadLater.articlesPath = os.getenv('HOME') .. "/Dropbox/read-later.json"
ReadLater.articles = {}

local saveCurrentTabArticle = nil
local buildMenu = nil

local function readArticlesFromDisk()
  local file = io.open(ReadLater.articlesPath, 'r')

  if file then
    local contents = file:read("*all")
    file:close()

    ReadLater.articles = hs.json.decode(contents) or {}
    buildMenu()
  end
end

local function writeArticlesToDisk()
  hs.json.write(ReadLater.articles, ReadLater.articlesPath, true, true)
end

local function openUrl(url)
  local task = hs.task.new(
    "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome",
    nil,
    function() end, -- noop
    {
      url
    }
  )

  task:start()
end

local function removeArticle(article)
  ReadLater.articles = hs.fnutils.filter(ReadLater.articles, function(savedArticle)
    return savedArticle.url ~= article.url
  end)

  buildMenu()
  writeArticlesToDisk()
end

local function isChromeRunning()
  return not not hs.application.find('Google Chrome')
end

local function readArticle(article)
  openUrl(article.url)
  removeArticle(article)
end

local function readRandomArticle()
  local index = math.random(1, #ReadLater.articles)
  readArticle(ReadLater.articles[index])
end

buildMenu = function()
  local items = {
    {
      title = "ReadLater",
      disabled = true
    },
    { title = "-" },
  }

  if #ReadLater.articles == 0 then
    table.insert(items, {
      title = "No more articles to read",
      disabled = true
    })
  else
    for _, article in ipairs(ReadLater.articles) do
      table.insert(items, {
        title = article.title,
        fn = function()
          readArticle(article)
        end,
        menu = {
          {
            title = "Remove article",
            fn = function()
              removeArticle(article)
            end,
          },
        }
      })
    end
  end

  table.insert(items, { title = "-" })
  table.insert(items, {
    title = "Save current tab          (⌘⌥⌃ S)",
    fn = function()
      saveCurrentTabArticle()
    end,
  })

  table.insert(items, {
    title = "Read random article",
    fn = readRandomArticle,
  })

  ReadLater.menu:setMenu(items)
  ReadLater.menu:setTitle("(" .. tostring(#ReadLater.articles) .. ")")
end

saveCurrentTabArticle = function()
  local script = [[
    tell application "Google Chrome"
      get title of active tab of first window
    end tell
  ]]

  local _, title = hs.osascript.applescript(script)

  -- remove trailing garbage from window title
  title = string.gsub(title, "- - Google Chrome.*", "")

  script = [[
    tell application "Google Chrome"
      get URL of active tab of first window
    end tell
  ]]

  local _, url = hs.osascript.applescript(script)

  table.insert(ReadLater.articles, {
    title = title,
    url = url,
  })

  writeArticlesToDisk()
  buildMenu()

  hs.alert("Saved " .. title)
end

superKey:bind('s'):toFunction('Read later', saveCurrentTabArticle)

----

readArticlesFromDisk()