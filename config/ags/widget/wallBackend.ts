import { execAsync } from "ags/process"

export const WALLPAPER_DIR = `${import.meta.env.HOME}/Pictures/Wallpapers`

export function setWallpaper(path: string) {
    // Example using swww, but you can use hyprpaper or feh
    execAsync(["awww", "img", path, "--transition-type", "outer"])
    .catch(err => console.error("Failed to set wallpaper", err))
}
