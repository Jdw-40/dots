import Gtk from "gi://Gtk?version=4.0";
import AstalTray from "gi://AstalTray";
import { For, createBinding, createState } from "ags";

export default function Tray() {
  const tray = AstalTray.get_default();
  const items = createBinding(tray, "items");

  // FIX: Destructure createState into a distinct reader Accessor and writer Setter
  const [getExpanded, setExpanded] = createState(false);

  const init = (btn: Gtk.MenuButton, item: AstalTray.TrayItem) => {
    btn.menuModel = item.menuModel;
    btn.insert_action_group("dbusmenu", item.actionGroup);

    const popover = btn.get_popover();
    if (popover) {
      popover.has_arrow = false;
      popover.cascade_popdown = true;
      popover.margin_bottom = 0;
      popover.margin_top = 0;
      popover.margin_start = 0;
      popover.margin_end = 0;
    }

    item.connect("notify::action-group", () => {
      btn.insert_action_group("dbusmenu", item.actionGroup);
    });
  };

  return (
    <box cssClasses={["tray-group", "flat"]} valign={Gtk.Align.CENTER}>
      
      {/* Toggle Button */}
      <button
        cssClasses={["flat", "tray-toggle"]}
        // Use setExpanded to update the state, and getExpanded() to read it
        onClicked={() => setExpanded(!getExpanded())}
        valign={Gtk.Align.CENTER}
      >
        {/* Pass the accessor to transform the text label reactively */}
        <label label={getExpanded((open) => (open ? "󱊖 󰅂" : "󰅁 󱊖"))} />
      </button>

      {/* Sliding Revealer container */}
      <revealer
        // Pass the raw reader accessor object straight to your boolean prop
        revealChild={getExpanded}
        transitionType={Gtk.RevealerTransitionType.SLIDE_LEFT}
        transitionDuration={250}
      >
        <box cssClasses={["tray-items-container"]} spacing={4}>
          <For each={items}>
            {(item) => (
              <menubutton
                $={(self) => init(self, item)}
                cssClasses={["tray-item", "flat"]}
                heightRequest={24}
                valign={Gtk.Align.CENTER}
              >
                <image gicon={createBinding(item, "gicon")} />
              </menubutton>
            )}
          </For>
        </box>
      </revealer>

    </box>
  );
}