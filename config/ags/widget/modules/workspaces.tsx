import AstalHyprland from "gi://AstalHyprland"
import { createBinding, createState, createComputed, createEffect, For } from "ags"

const KANJI: Record<number, string> = {
  1: "一", 2: "二", 3: "三", 4: "四", 5: "五",
  6: "六", 7: "七", 8: "八", 9: "九", 10: "十",
  11: "十一", 12: "十二", 13: "十三", 14: "十四", 15: "十五",
  16: "十六", 17: "十七", 18: "十八", 19: "十九", 20: "二十",
}
const URGENT = "●" // Your circle indicator
const DEFAULT = "●"

export default function WorkspacesWidget() {
  const hyprland = AstalHyprland.get_default()
  const workspaces = createBinding(hyprland, "workspaces")
  const focusedWorkspace = createBinding(hyprland, "focusedWorkspace")

  // Track urgent workspace IDs via a simple Set state.
  const [urgentIds, setUrgentIds] = createState<Set<number>>(new Set())

  // Connect directly to the "urgent" event signal on the hyprland instance
  hyprland.connect("urgent", (_, client) => {
    if (!client) return
    const wsId = client.workspace?.id
    if (wsId == null) return

    setUrgentIds(prev => {
      const next = new Set(prev)
      next.add(wsId)
      return next
    })
  })

  // FIX: Use createEffect to handle state side-effects when focusedWorkspace updates
  createEffect(() => {
    const fw = focusedWorkspace() // Track dependency
    if (!fw) return

    setUrgentIds(prev => {
      if (!prev.has(fw.id)) return prev // Don't trigger useless state updates
      const next = new Set(prev)
      next.delete(fw.id)
      return next
    })
  })

  return (
    <box name="workspaces">
      <For
        each={workspaces.as((wss) =>
          wss
            .filter((ws) => ws.id > 0)
            .sort((a, b) => a.id - b.id)
        )}
      >
        {(ws: AstalHyprland.Workspace) => {
          const clients = createBinding(ws, "clients")

          return (
            <button
              name={`workspace-${ws.id}`}
              hasFrame={false}
              focusOnClick={false}
              cssClasses={createComputed(() => {
                const fw = focusedWorkspace()
                const cs = clients()
                const uids = urgentIds()

                return [
                  "flat",
                  "workspace",
                  fw?.id === ws.id ? "focused" : "",
                  uids.has(ws.id) ? "urgent" : "",
                  cs && cs.length > 0 ? "occupied" : "",
                ].filter(Boolean)
              })}
              onClicked={() => hyprland.dispatch("workspace", ws.id.toString())}
            >
              <label label={urgentIds.as((uids) =>
                uids.has(ws.id)
                  ? URGENT
                  : (KANJI[ws.id] ?? DEFAULT)
              )} />
            </button>
          )
        }}
      </For>
    </box>
  )
}