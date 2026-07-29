local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.color_scheme = "Tokyo Night"
config.font = wezterm.font("Hack Nerd Font")
config.font_size = 15.0
config.window_background_opacity = 0.9 
macos_window_background_blur = 50
config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = "TITLE | RESIZE"

local function paste_from_windows(window, pane)
  local success, stdout = wezterm.run_child_process({ "win32yank.exe", "-o", "--lf" })
  if success then
    pane:send_text(stdout)
  end
end

config.keys = {
  {
    key = "v",
    mods = "CTRL",
    action = wezterm.action_callback(paste_from_windows),
  },
}

config.mouse_bindings = {
  {
    event = { Up = { streak = 1, button = "Right" } },
    mods = "NONE",
    action = wezterm.action_callback(paste_from_windows),
  },
}

return config
