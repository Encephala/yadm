Name = "zed-workspaces"
NamePretty = "Zed Workspaces"
Icon = "text-editor"
Terminal = false
Cache = false
History = true
HistoryWhenEmpty = true
FixedOrder = true
Action = 'zeditor "%VALUE%"'

-- Reads Zed's own recent-workspaces db (no Zed-specific API needed, it's plain sqlite).
function GetEntries()
  local home = os.getenv("HOME")
  local db = home .. "/.local/share/zed/db/0-stable/db.sqlite"

  local query = "SELECT paths FROM workspaces "
    .. "WHERE paths IS NOT NULL AND paths != '' "
    .. "ORDER BY timestamp DESC LIMIT 20;"

  local cmd = string.format('sqlite3 -readonly "%s" "%s" 2>/dev/null', db, query)
  local handle = io.popen(cmd)
  if not handle then
    return {}
  end

  local entries = {}
  for line in handle:lines() do
    if line ~= "" then
      local name = line:match("([^/]+)/?$") or line
      table.insert(entries, {
        Text = name,
        Subtext = line,
        Value = line,
        Icon = "folder",
      })
    end
  end
  handle:close()

  return entries
end
