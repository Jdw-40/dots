--Catpuccin Mocha theme file
hl.config({
    general={
        gaps_in=4,
        gaps_out=12,
        border_size=2,
        col={
            active_border={colors={"#957FB8", "#E6C384"}, angle=45},
            inactive_border={colors={"#54546D"}, angle=45}
        },
        resize_on_border=true
    },
    decoration = {
        rounding = 4,
        rounding_power = 2.0,
        active_opacity = 1.0,
        inactive_opacity = 0.85,
        dim_inactive = true,
        dim_strength = 0.15,
        blur = {
            enabled = true,
            size = 6,
            passes = 3,
            ignore_opacity = true,
            new_optimizations = true,
            xray = false,
            popups = false
        },
        shadow = {
            enabled = true,
            color = "#16161Dcc", -- color0 at 80% alpha
            range = 12,
            render_power = 3
        }
    }
})
