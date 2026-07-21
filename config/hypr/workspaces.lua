hl.workspace_rule({ workspace = "special:special", layout = "scrolling" })

hl.config({
    scrolling = {
      column_width=1
    }
})
-- ----------------------
-- | Workspace Rules    |
-- ----------------------

-- Persistent workspaces (always shown in bar even when empty)
for i = 1, 10 do
    hl.workspace_rule({ workspace = tostring(i), persistent = true })
    end
