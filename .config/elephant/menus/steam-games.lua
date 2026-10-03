Name = "steam-games"
NamePretty = "Steam Games"
Icon = "steam"
Terminal = false
Cache = false
History = true
HistoryWhenEmpty = true
Action = 'steam steam://rungameid/%VALUE%'

-- Steam installs Proton/runtimes as regular "apps"; hide them.
local hidden = { "^Proton", "^Steam Linux Runtime", "^Steamworks Common" }

local function is_hidden(name)
  for _, pattern in ipairs(hidden) do
    if name:match(pattern) then
      return true
    end
  end
  return false
end

-- Reads appmanifest_*.acf from every library listed in libraryfolders.vdf (plain text, no Steam API needed).
function GetEntries()
  local steam = os.getenv("HOME") .. "/.local/share/Steam"

  local libraries = {}
  local vdf = io.open(steam .. "/steamapps/libraryfolders.vdf")
  if vdf then
    for line in vdf:lines() do
      local path = line:match('^%s*"path"%s*"(.-)"')
      if path then
        table.insert(libraries, path)
      end
    end
    vdf:close()
  end
  if #libraries == 0 then
    libraries = { steam }
  end

  local entries = {}
  for _, library in ipairs(libraries) do
    local handle = io.popen(string.format('ls "%s"/steamapps/appmanifest_*.acf 2>/dev/null', library))
    if handle then
      for manifest in handle:lines() do
        local file = io.open(manifest)
        if file then
          local content = file:read("*a")
          file:close()

          local appid = content:match('"appid"%s*"(%d+)"')
          local name = content:match('"name"%s*"(.-)"')
          if appid and name and not is_hidden(name) then
            -- Steam caches the small client icon as <sha1>.jpg next to header.jpg etc.
            local icon = "steam"
            local icons = io.popen(string.format('ls "%s"/appcache/librarycache/%s/ 2>/dev/null', steam, appid))
            if icons then
              for f in icons:lines() do
                if f:match("^%x+%.jpg$") and #f == 44 then
                  icon = steam .. "/appcache/librarycache/" .. appid .. "/" .. f
                  break
                end
              end
              icons:close()
            end

            table.insert(entries, {
              Text = name,
              Subtext = "Steam",
              Value = appid,
              Icon = icon,
            })
          end
        end
      end
      handle:close()
    end
  end

  return entries
end
