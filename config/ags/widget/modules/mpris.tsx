import GLib from "gi://GLib"
import Gtk from "gi://Gtk?version=4.0"
import Pango from "gi://Pango"
import Mpris from "gi://AstalMpris"
import { For, createBinding } from "ags"

const IGNORED = ["firefox", "chromium", "brave", "edge", "zen"]

function formatTime(seconds: number): string {
  if (seconds <= 0) return "0:00"
  const h = Math.floor(seconds / 3600)
  const m = Math.floor((seconds % 3600) / 60)
  const s = Math.floor(seconds % 60)
  const ps = s < 10 ? `0${s}` : `${s}`
  if (h > 0) {
    const pm = m < 10 ? `0${m}` : `${m}`
    return `${h}:${pm}:${ps}`
  }
  return `${m}:${ps}`
}

function PlayerWidget({ player }: { player: Mpris.Player }) {
  const title    = createBinding(player, "title")
  const artist   = createBinding(player, "artist")
  const album    = createBinding(player, "album")
  const coverArt = createBinding(player, "coverArt")
  const pbStatus  = createBinding(player, "playbackStatus")  // bar icon
  const pbStatus2 = createBinding(player, "playbackStatus")  // popover play/pause button
  const pbStatus3 = createBinding(player, "playbackStatus")  // subscribe side-effect
  const identity  = createBinding(player, "identity")

  const nowPlaying = createBinding(player, "metadata")(() => {
    const a = player.artist ?? ""
    const t = player.title  ?? ""
    return (a && t) ? `${a} - ${t}` : (t || a || "")
  })

  let positionLabel: Gtk.Label | null = null
  let sliderWidget:  Gtk.Scale | null = null
  let timerId: number | null = null

  const syncUI = () => {
    const current = player.position ?? 0
    const total   = player.length   ?? 0
    if (positionLabel) {
      positionLabel.label = total > 0
        ? `${formatTime(current)} / ${formatTime(total)}`
        : formatTime(current)
    }
    if (sliderWidget && !sliderWidget.has_focus) {
      sliderWidget.adjustment.value = total > 0 ? Math.min(current / total, 1) : 0
    }
  }

  const startTimer = () => {
    if (timerId !== null) return
    syncUI()
    timerId = GLib.timeout_add_seconds(GLib.PRIORITY_DEFAULT, 1, () => {
      syncUI()
      return GLib.SOURCE_CONTINUE
    })
  }

  const stopTimer = () => {
    if (timerId !== null) {
      GLib.source_remove(timerId)
      timerId = null
    }
    syncUI()
  }

  let lastStatus: Mpris.PlaybackStatus | null = null
  pbStatus3((s) => {
    if (s !== lastStatus) {
      lastStatus = s
      if (s === Mpris.PlaybackStatus.PLAYING) startTimer()
      else stopTimer()
    }
    return s
  })

  return (
    <menubutton
      hasFrame={false}
      cssClasses={["flat", "mpris-button"]}
      visible={nowPlaying((np) => np.length > 0)}
    >
      <box spacing={8}>
        <label label={pbStatus((s) =>
          s === Mpris.PlaybackStatus.PLAYING ? "" : ""
        )} />
        <label ellipsize={Pango.EllipsizeMode.END} label={nowPlaying} />
      </box>

      <popover
        $={(self) => {
          self.has_arrow = false
          self.cascade_popdown = true
          self.margin_bottom = 0
          self.margin_top    = 0
          self.margin_start  = 0
          self.margin_end    = 0
          self.connect("map", () => {
            if (player.playbackStatus === Mpris.PlaybackStatus.PLAYING) startTimer()
            else syncUI()
          })
          self.connect("unmap", () => stopTimer())
        }}
      >
        <box orientation={Gtk.Orientation.VERTICAL} css="padding: 16px;" spacing={12}>

          {/* Top row: cover art + track info + progress */}
          <box spacing={16}>

            {/* Cover art — 120x120 */}
            <box
              valign={Gtk.Align.START}
              css={coverArt((art) => `
                background-image: url('${art ? (art.startsWith("file://") ? art : `file://${art}`) : ""}');
                background-size: cover;
                background-position: center;
                min-width: 120px;
                min-height: 120px;
                border-radius: 10px;
                background-color: #313244;
              `)}
            >
              <image
                visible={coverArt((art) => !art)}
                iconName="audio-x-generic-symbolic"
                css="font-size: 48px; opacity: 0.3;"
              />
            </box>

            {/* Track info + progress */}
            <box orientation={Gtk.Orientation.VERTICAL} valign={Gtk.Align.CENTER} hexpand={true} spacing={4}>
              <label
                css="font-size: 0.75rem; opacity: 0.8; margin-bottom: 2px;"
                halign={Gtk.Align.START}
                label="Now playing"
              />
              <label
                css="font-weight: bold; font-size: 1.05rem;"
                halign={Gtk.Align.START}
                ellipsize={Pango.EllipsizeMode.END}
                label={title((t) => t ?? "")}
              />
              <label
                css="opacity: 0.8; font-size: 0.9rem;"
                halign={Gtk.Align.START}
                ellipsize={Pango.EllipsizeMode.END}
                label={artist((a) => a ? `Artist: ${a}` : "")}
              />
              <label
                css="opacity: 0.8; font-size: 0.9rem;"
                halign={Gtk.Align.START}
                ellipsize={Pango.EllipsizeMode.END}
                visible={album((a) => Boolean(a))}
                label={album((a) => a ? `Album: ${a}` : "")}
              />

              {/* Progress bar */}
              <box orientation={Gtk.Orientation.VERTICAL} spacing={0} css="margin-top: 8px;">
                <slider
                  widthRequest={220}
                  drawValue={false}
                  $={(self) => {
                    sliderWidget = self
                    self.set_range(0, 1)
                  }}
                  onValueChanged={(self: Gtk.Scale) => {
                    if (!self.has_focus) return
                    const total = player.length ?? 0
                    if (total > 0) player.set_position(self.adjustment.value * total)
                  }}
                />
                <label
                  css="font-size: 0.75rem; opacity: 0.5;"
                  halign={Gtk.Align.END}
                  $={(self) => { positionLabel = self }}
                />
              </box>
            </box>
          </box>

          {/* Controls */}
          <box halign={Gtk.Align.CENTER} spacing={20}>
            <button hasFrame={false} cssClasses={["flat"]} onClicked={() => player.previous()}>
              <image iconName="media-skip-backward-symbolic" />
            </button>
            <button hasFrame={false} cssClasses={["flat", "mpris-play"]} onClicked={() => player.play_pause()}>
              <image iconName={pbStatus2((s) =>
                s === Mpris.PlaybackStatus.PLAYING
                  ? "media-playback-pause-symbolic"
                  : "media-playback-start-symbolic"
              )} />
            </button>
            <button hasFrame={false} cssClasses={["flat"]} onClicked={() => player.next()}>
              <image iconName="media-skip-forward-symbolic" />
            </button>
          </box>

          {/* Stat row: player name inline */}
          <box cssClasses={["mpris-stat"]} spacing={6}>
            <label css="font-size: 0.8rem; opacity: 0.5;" label="Player:" />
            <label
              css="font-size: 0.8rem; font-weight: bold;"
              halign={Gtk.Align.START}
              ellipsize={Pango.EllipsizeMode.END}
              label={identity((i) => i ?? "Unknown")}
            />
          </box>

        </box>
      </popover>
    </menubutton>
  )
}

export default function Media() {
  const players = createBinding(Mpris.get_default(), "players")
  const filtered = players((ps) =>
    ps.filter(p => {
      const id = (p.identity ?? p.busName ?? "").toLowerCase()
      return id && !IGNORED.some(i => id.includes(i))
    })
  )
  return (
    <box>
      <For each={filtered}>
        {(player) => <PlayerWidget player={player} />}
      </For>
    </box>
  )
}