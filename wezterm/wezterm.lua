-- ============================================================================
-- Minimalist, Aesthetic, Dark Grok Theme for WezTerm
-- ============================================================================

local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- ----------------------------------------------------------------------------
-- Grok Obsidian Palette (graphite / ivory / steel)
-- ----------------------------------------------------------------------------
local grok = {
  bg0_h        = "#0C0C0C", -- Chrome / tab bar
  bg0          = "#141414", -- Terminal canvas (GrokNight)
  bg1          = "#1A1A1A", -- Active tab / raised surface
  bg2          = "#262B30", -- Selection
  bg3          = "#1C1C1C", -- Muted surface
  bg4          = "#2A2A2A", -- Borders / scrollbar

  fg0          = "#F2F0EB", -- Bright foreground
  fg1          = "#E6E4DF", -- Main foreground
  fg2          = "#C4BBAE", -- Soft foreground
  fg3          = "#9A9892", -- Dim foreground
  fg4          = "#7C7B76", -- Darker foreground

  black        = "#1A1A1A",
  bright_black = "#3A3A3A",

  red          = "#C98F87",
  bright_red   = "#D6A09A",

  green        = "#93AF97",
  bright_green = "#AEC9B1",

  yellow       = "#C2B086",
  bright_yellow= "#D8C79B",

  blue         = "#8FA9C0",
  bright_blue  = "#AAC2D6",

  purple       = "#B49BB0",
  bright_purple= "#CBB2C7",

  aqua         = "#8AAFA9",
  bright_aqua  = "#A5C9C2",

  orange       = "#A9BCCB",
  bright_orange= "#C4D6E4",

  gray         = "#5F5E5A",
}

-- Apply custom aesthetic Grok Obsidian color scheme
config.color_schemes = {
  ["Grok Obsidian"] = {
    foreground = grok.fg1,
    background = grok.bg0,

    cursor_bg = grok.bright_orange,
    cursor_fg = grok.bg0_h,
    cursor_border = grok.bright_orange,

    selection_fg = grok.fg0,
    selection_bg = grok.bg2,

    scrollbar_thumb = grok.bg4,
    split = grok.bg4,

    ansi = {
      grok.black,
      grok.red,
      grok.green,
      grok.yellow,
      grok.blue,
      grok.purple,
      grok.aqua,
      grok.fg1,
    },
    brights = {
      grok.bright_black,
      grok.bright_red,
      grok.bright_green,
      grok.bright_yellow,
      grok.bright_blue,
      grok.bright_purple,
      grok.bright_aqua,
      grok.fg0,
    },
    indexed = {
      [16] = grok.bright_orange,
      [17] = grok.bright_red,
    },

    tab_bar = {
      background = grok.bg0,
      inactive_tab_edge = grok.bg0,

      active_tab = {
        bg_color = grok.bg1,
        fg_color = grok.bright_orange,
        intensity = "Bold",
        underline = "None",
        italic = false,
        strikethrough = false,
      },

      inactive_tab = {
        bg_color = grok.bg0,
        fg_color = grok.gray,
      },

      inactive_tab_hover = {
        bg_color = grok.bg3,
        fg_color = grok.fg1,
        italic = false,
      },

      new_tab = {
        bg_color = grok.bg0,
        fg_color = grok.gray,
      },

      new_tab_hover = {
        bg_color = grok.bg1,
        fg_color = grok.bright_orange,
      },
    },
  },
}

config.color_scheme = "Grok Obsidian"

-- ----------------------------------------------------------------------------
-- Typography & Font Configuration
-- ----------------------------------------------------------------------------
config.font = wezterm.font_with_fallback({
  { family = "JetBrainsMono Nerd Font", weight = "Medium" },
  { family = "JetBrainsMono NFM", weight = "Medium" },
  { family = "JetBrains Mono", weight = "Medium" },
  { family = "Fira Code", weight = "Regular" },
  { family = "Cascadia Code", weight = "Regular" },
  { family = "Consolas", weight = "Regular" },
  { family = "Monospace", weight = "Regular" },
})

config.font_size = 10.0
config.line_height = 1.0
config.adjust_window_size_when_changing_font_size = false

config.window_frame = {
  font = wezterm.font({ family = "JetBrains Mono", weight = "Bold" }),
  font_size = 10.0,
  active_titlebar_bg = "#141414",
  inactive_titlebar_bg = "#141414",
  active_titlebar_border_bottom = "#141414",
  inactive_titlebar_border_bottom = "#141414",
}

-- ----------------------------------------------------------------------------
-- Window Appearance & Aesthetics
-- ----------------------------------------------------------------------------
config.window_decorations = "RESIZE"
config.window_background_opacity = 0.96
config.win32_system_backdrop = "Mica"

config.window_padding = {
  left = 16,
  right = 16,
  top = 14,
  bottom = 14,
}

-- Initial window geometry & Shell
config.default_prog = { "pwsh.exe", "-NoLogo" }
config.initial_cols = 210
config.initial_rows = 50

-- GPU Acceleration & Performance Settings
config.front_end = "WebGpu"
config.webgpu_power_preference = "HighPerformance"
config.max_fps = 240
config.animation_fps = 240

-- Scrollbar & Cursor (Default)
config.enable_scroll_bar = false
config.default_cursor_style = "BlinkingBlock"

-- Dim inactive panes for clear visual focus
config.inactive_pane_hsb = {
  saturation = 0.85,
  brightness = 0.75,
}

-- ----------------------------------------------------------------------------
-- Minimalist Custom Tab Bar & Status Line
-- ----------------------------------------------------------------------------
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = false
config.hide_tab_bar_if_only_one_tab = false
config.tab_max_width = 28

-- Custom Tab Title Formatting
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
  local is_active = tab.is_active
  local bg = is_active and grok.bg1 or grok.bg0
  local fg = is_active and grok.bright_orange or grok.gray
  local index_bg = is_active and grok.bright_orange or grok.bg2
  local index_fg = is_active and grok.bg0_h or grok.fg4

  if hover and not is_active then
    bg = grok.bg3
    fg = grok.fg1
  end

  local title = tab.active_pane.title
  if not title or title == "" then
    title = tab.active_pane.foreground_process_name or "terminal"
    title = title:match("([^/\\]+)$") or title
  end

  -- Clean truncation if title is long
  if #title > 18 then
    title = title:sub(1, 15) .. "..."
  end

  local index_str = string.format(" %d ", tab.tab_index + 1)

  return {
    { Background = { Color = index_bg } },
    { Foreground = { Color = index_fg } },
    { Attribute = { Intensity = "Bold" } },
    { Text = index_str },
    { Background = { Color = bg } },
    { Foreground = { Color = fg } },
    { Text = string.format(" %s ", title) },
  }
end)

-- Custom Status Bar (Right side)
wezterm.on("update-status", function(window, pane)
  local workspace = window:active_workspace()
  local time = wezterm.strftime("%H:%M")
  local date = wezterm.strftime("%b %d")
  local leader = ""

  if window:leader_is_active() then
    leader = " 🗲 LEADER "
  end

  local status = {}

  if leader ~= "" then
    table.insert(status, { Background = { Color = grok.bright_orange } })
    table.insert(status, { Foreground = { Color = grok.bg0_h } })
    table.insert(status, { Attribute = { Intensity = "Bold" } })
    table.insert(status, { Text = leader })
  end

  -- Workspace pill
  table.insert(status, { Background = { Color = grok.bg1 } })
  table.insert(status, { Foreground = { Color = grok.bright_aqua } })
  table.insert(status, { Text = string.format(" %s ", workspace) })

  -- Date & Time pill
  table.insert(status, { Background = { Color = grok.bg2 } })
  table.insert(status, { Foreground = { Color = grok.fg0 } })
  table.insert(status, { Text = string.format(" %s %s ", date, time) })

  window:set_right_status(wezterm.format(status))
end)

-- ----------------------------------------------------------------------------
-- Ergonomic Keybindings & Leader Key
-- ----------------------------------------------------------------------------
config.leader = { key = "Space", mods = "SHIFT", timeout_milliseconds = 1000 }

-- Toggle the active window between maximized and restored.
local maximized = {}
local function toggle_maximize(window)
  local id = window:window_id()
  if maximized[id] then
    window:restore()
    maximized[id] = nil
  else
    window:maximize()
    maximized[id] = true
  end
end

config.keys = {
  -- Split Panes (Leader + | for Horizontal, Leader + - for Vertical)
  { key = "|", mods = "LEADER|SHIFT", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
  { key = "-", mods = "LEADER", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
  { key = "x", mods = "LEADER", action = wezterm.action.CloseCurrentPane({ confirm = true }) },

  -- Navigation between Panes
  { key = "h", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Left") },
  { key = "l", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Right") },
  { key = "k", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Up") },
  { key = "j", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Down") },

  -- Tabs
  { key = "c", mods = "LEADER", action = wezterm.action.SpawnTab("CurrentPaneDomain") },
  { key = "n", mods = "LEADER", action = wezterm.action.ActivateTabRelative(1) },
  { key = "p", mods = "LEADER", action = wezterm.action.ActivateTabRelative(-1) },

  -- Quick Config Reload
  { key = "r", mods = "LEADER", action = wezterm.action.ReloadConfiguration },

  -- Window management
  { key = "q", mods = "LEADER", action = wezterm.action.CloseCurrentTab({ confirm = true }) },
  { key = "f", mods = "LEADER", action = wezterm.action_callback(toggle_maximize) },
  { key = "m", mods = "LEADER", action = wezterm.action.Hide },
}

-- Tab navigation with numbers (Leader + 1..9)
for i = 1, 9 do
  table.insert(config.keys, {
    key = tostring(i),
    mods = "LEADER",
    action = wezterm.action.ActivateTab(i - 1),
  })
end

return config
