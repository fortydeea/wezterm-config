local wezterm = require("wezterm")
local mux = wezterm.mux
local config = wezterm.config_builder()

local function is_windows()
	return wezterm.target_triple:find("windows") ~= nil
end

local function is_windows_arm()
	return wezterm.target_triple == "aarch64-pc-windows-msvc" or os.getenv("PROCESSOR_ARCHITECTURE") == "ARM64"
end

-- Disable close window/tab prompt
config.window_close_confirmation = "NeverPrompt"

wezterm.on("mux-is-process-stateful", function(proc)
	return false -- never prompt, regardless of what's running in the pane
end)

-- Start full screen
wezterm.on("gui-startup", function(cmd)
	local _, _, window = mux.spawn_window(cmd or {})
	local gui_window = window:gui_window()
	gui_window:maximize()
end)

-- Font
config.font = wezterm.font("Hack Nerd Font Mono")
config.font_size = 14

-- Appearance
config.color_scheme = "PencilDark"
config.window_background_opacity = 0.8
config.enable_tab_bar = true

-- Animation
config.animation_fps = 60
config.max_fps = 60

if is_windows_arm() then
	config.front_end = "WebGpu"
else
	config.front_end = "OpenGL"
end

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
