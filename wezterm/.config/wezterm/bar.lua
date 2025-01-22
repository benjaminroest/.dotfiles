local M = {}
local wezterm = require("wezterm")
local utils = require("utils")
local colors = require("colors.catppuccin").colors

M.setup = function()
  -- `update-status` is emitted based on the interval specified by the
  -- `status_update_interval` configuration value (default 1000)
  wezterm.on("update-status", function(window)
    -- Show which key table is active in the status area
    -- Also show when leader is active
    local name = window:active_key_table()
    if name then
      name = wezterm.format({
        { Attribute = { Intensity = "Bold" } },
        { Foreground = { Color = colors.mantle } },
        { Background = { Color = colors.peach } },
        {
          Text = string.upper(" ddf" .. string.gsub(name, "_", " ")) .. " ",
        },
      })
    elseif window:leader_is_active() then
      name = wezterm.format({
        { Attribute = { Intensity = "Bold" } },
        { Foreground = { Color = colors.mantle } },
        { Background = { Color = colors.blue } },
        { Text = " LEADER " },
      })
    end
    window:set_right_status((name or "") .. window:active_workspace())
  end)

  -- Tab title
  wezterm.on("format-tab-title", function(tab)
    local title = tab.tab_title
    if title == "" then
      title = utils.get_current_working_dir(tab)
    end

    title = string.format(" %s", title)

    return wezterm.format({
      { Attribute = { Intensity = "Bold" } },
      { Text = string.format(" %s ", tab.tab_index + 1) },
      "ResetAttributes",
      { Text = utils.get_process_icon(tab) },
      { Text = title },
      { Foreground = { Color = colors.base } },
      { Text = " ▕" },
    })
  end)
end

return M
