import { Gtk } from "ags/gtk4"
import { createState } from "ags"
import { exec } from "ags/process"
import { WALLPAPER_DIR, setWallpaper } from "./wallBackend"


export default function WallpaperSelector() {
  // Fetch wallpaper list as state (not destructured with [])
  const images = createState<string>([])

  // Load wallpapers on mount/update (async)
  const loadImages = () => {
    return exec(`ls -1 "${WALLPAPER_DIR}"`)
      .then(output => 
        output
          .split("\n")
          .filter(f => f.trim().match(/\.(jpg|jpeg|png|webp)$/i))
      )
  }

  // Initialize images list when state changes or on mount
  const refreshImages = () => {
    loadImages().then(list => images.list = list)
  }

  // Load initially
  refreshImages()

  return (
    <box vertical class="WallpaperSelector" spacing={12}>
      <label label="Select Wallpaper" class="title" halign={Gtk.Align.START} />
      
      <Gtk.ScrolledWindow propVexpand propMinContentHeight={400}>
        <Gtk.FlowBox 
          class="wallpaper-grid"
          selectionMode={Gtk.SelectionMode.NONE}
          $={(self) => {
            // Load wallpapers into FlowBox
            images.get().forEach(img => {
              const path = `${WALLPAPER_DIR}/${img.trim()}`
              self.insert(
                (<button 
                    onClicked={() => setWallpaper(path)} // Note: use onClicked for Gtk.Button
                    class="wallpaper-card"
                >
                    <box 
                    class="preview-img" 
                    css={`background-image: url("${path}");`} 
                    />
                    </button> as any), // Cast to 'any' or 'Gtk.Widget'
                    -1
                )
            })
            
            // Handle selectionMode if needed
            self.selected.connect(selection => {
              console.log("Selected:", selection)
            })
          }}
        />
      </Gtk.ScrolledWindow>
    </box>
  )
}
