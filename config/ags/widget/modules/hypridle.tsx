import { execAsync } from "ags/process"
import { createPoll } from "ags/time"

const isIdleActive = createPoll(false, 2000, () =>
  execAsync("pgrep -x hypridle")
    .then(() => true)
    .catch(() => false)
)

export default function Hypridle() {
  const toggle = () => {
    if (isIdleActive.get()) {
      execAsync("pkill hypridle").catch(print)
    } else {
      execAsync("hypridle &").catch(print)
    }
  }

  return (
    <button
      name="hypridle"
      hasFrame={false}
      onClicked={toggle}
      tooltipText={isIdleActive((active) =>
        active ? " Caffeine Mode Active\nPrevents system from going to sleep"
               : " Caffeine Mode Inactive\nSystem will follow normal power settings"
      )}
      cssClasses={isIdleActive((active) => ["flat", "hypridle", active ? "active" : "inhibited"])}
    >
      <label label={isIdleActive((active) => active ? "󰛊" : "󰅶")} />
    </button>
  )
}