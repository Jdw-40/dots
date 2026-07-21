import Wp from "gi://AstalWp"
import { createBinding } from "gnim"
import { attachHoverScroll } from "./utils.ts"

const CHANGE_SPEED = 0.02

export function Volume() {
  const wp = Wp.get_default()
  const defaultSpeaker = wp.audio.default_speaker

  return (
    <menubutton
      hasFrame={false}
      focusOnClick={false}
      cssClasses={["flat", "volume-button"]}
    >
      <box
        spacing={6}
        $={(self) => {
          attachHoverScroll(self, ({ dy }) => {
            defaultSpeaker.volume -= CHANGE_SPEED * dy
          })
        }}
      >
        <image iconName={createBinding(defaultSpeaker, "volumeIcon")} />
        <label
          label={createBinding(
            defaultSpeaker,
            "volume",
          )((volume) => `${Math.round(volume * 100)}%`)}
        />
      </box>
      <popover
        $={(self) => {
          self.has_arrow = false
          self.cascade_popdown = true
          self.margin_bottom = 0
          self.margin_top = 0
          self.margin_start = 0
          self.margin_end = 0
        }}
      >
        <box>
          <slider
            widthRequest={260}
            onChangeValue={({ value }) => defaultSpeaker.set_volume(value)}
            value={createBinding(defaultSpeaker, "volume")}
          />
        </box>
      </popover>
    </menubutton>
  )
}