import GLib from "gi://GLib"
import Gtk from "gi://Gtk?version=4.0"
import { createPoll } from "ags/time"

export default function Clock({ format = "%T \udb80\udced %d\u00b7%m\u00b7%y" }) {
  const time = createPoll(
    GLib.DateTime.new_now_local().format(format)!,
    1000,
    () => GLib.DateTime.new_now_local().format(format)!
  )

  return (
    <menubutton
      hasFrame={false}
      focusOnClick={false}
      cssClasses={["flat", "clock-button"]}
    >
      <label label={time} />
      <popover
        $={(self) => {
          self.has_arrow = false;
          self.cascade_popdown = true;
          self.margin_bottom = 0;
          self.margin_top = 0;
          self.margin_start = 0;
          self.margin_end = 0;
        }}
      >
        <Gtk.Calendar />
      </popover>
    </menubutton>
  )
}