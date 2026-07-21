import app from "ags/gtk4/app"
import style from "./style.scss"
import Bar from "./widget/Bar"

app.start({
  css: "./style.css",
  main() {
    app.get_monitors().map(Bar)
  },
})
