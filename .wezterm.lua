local wezterm = require("wezterm")
local config = wezterm.config_builder()

local function is_windows()
	return wezterm.target_triple:find("windows") ~= nil
end

-- Font
config.font = wezterm.font("Hack Nerd Font Mono")
config.font_size = 14

-- Appearance
config.color_scheme = "DoomOne"
config.window_background_opacity = 0.8
config.enable_tab_bar = true

-- Animation
config.animation_fps = 60
config.max_fps = 60
config.front_end = "WebGpu"

-- Windows-specific: launch straight into WSL instead of PowerShell
if is_windows() then
	config.default_domain = "WSL:Debian"
end

-- Config auto-reloads on save by default (automatically_reload_config),
-- but you can also bind a manual reload if you want it:
config.keys = {
	{
		key = "r",
		mods = "CTRL|SHIFT",
		action = wezterm.action.ReloadConfiguration,
	},
}

return config
