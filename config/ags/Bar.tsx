import app from "ags/gtk4/app"
import { Astal } from "ags/gtk4"
import { createPoll } from "ags/time"
import Clock from "./widget/modules/clock.tsx"
import Tray from "./widget/modules/tray.tsx"
import { Volume } from "/home/mrjw/.config/ags/widget/modules/volume"
import style from "./style.scss"
import Workspaces from "./widget/modules/workspaces.js"
import Hypridle from "./widget/modules/hypridle.tsx"
import Media from "./widget/modules/mpris.tsx"
app.start({
  css: style,
  main() {
    const { TOP, LEFT, RIGHT } = Astal.WindowAnchor
    const clock = createPoll("", 1000, "date")

    return (
      <window
        layer={Astal.Layer.TOP}
        exclusivity={Astal.Exclusivity.EXCLUSIVE}
        visible
        anchor={TOP | LEFT | RIGHT}
      >
        <centerbox>
          <box $type="start">
            <Workspaces />
          </box>,

          <box $type="center">
            <Hypridle/>
            <Clock />
          </box>,

          <box $type="end">
            <Media />
            <Volume />
            <Tray />
          </box>
        </centerbox>
      </window>
    )
  },
})
