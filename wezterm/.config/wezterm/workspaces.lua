local wezterm = require("wezterm")
local act = wezterm.action
local mux = wezterm.mux

local module = {}

local function pinepen_workspace()
  local project_dir = wezterm.home_dir .. '/personal/PinePen'
  local tab, build_pane, window = mux.spawn_window {
    workspace = 'PinePen',
    cwd = project_dir,
  }
  tab:set_title('Build')

  local git_pane = build_pane:split {
    direction = 'Right',
    cwd = project_dir,
  }

  local tab, be_pane, window = window:spawn_tab {
    cwd = project_dir .. '/src-tauri',
  }
  tab:set_title('Back-end')

  local tab, fe_pane, window = window:spawn_tab {
    cwd = project_dir,
  }
  tab:set_title('Front-end')

  build_pane:send_text 'npm run serve\n'
  git_pane:send_text 'git status --porcelain\n'
  be_pane:send_text 'nvim\n'
  fe_pane:send_text 'nvim\n'

  mux.set_active_workspace 'PinePen'
end

local function timespace_workspace()
  local project_dir = wezterm.home_dir .. '/personal/timespace'
  local tab, build_pane, window = mux.spawn_window {
    workspace = 'Timespace',
    cwd = project_dir,
  }
  tab:set_title('Build')

  local git_pane = build_pane:split {
    direction = 'Right',
    cwd = project_dir,
  }

  local tab, be_pane, window = window:spawn_tab {
    cwd = project_dir .. '/src-tauri',
  }
  tab:set_title('Back-end')

  local tab, fe_pane, window = window:spawn_tab {
    cwd = project_dir,
  }
  tab:set_title('Front-end')

  build_pane:send_text 'npm run serve\n'
  git_pane:send_text 'git status --porcelain\n'
  be_pane:send_text 'nvim\n'
  fe_pane:send_text 'nvim\n'

  mux.set_active_workspace 'Timespace'
end

local function kex_front_workspace()
  local project_dir = wezterm.home_dir .. '/Projects/kexxu-editor'

  local tab, fe_build_pane, window = mux.spawn_window {
    workspace = 'Kexxu-editor',
    cwd = project_dir,
  }
  local be_build_pane = fe_build_pane:split {
    direction = 'Right',
    cwd = wezterm.home_dir .. '/Projects/iot-api',
  }
  tab:set_title('Build')

  local tab, git_pane, window = window:spawn_tab {
    cwd = project_dir,
  }
  tab:set_title('Git')

  local tab, fe_pane, window = window:spawn_tab {
    cwd = project_dir,
  }
  tab:set_title('Front-end')

  fe_build_pane:send_text 'yarn run serve --host\n'
  be_build_pane:send_text './iot-api\n'
  git_pane:send_text 'git status --porcelain\n'
  fe_pane:send_text 'nvim\n'

  mux.set_active_workspace 'Kexxu-editor'
end

local function q_temp_workspace()
  local project_dir = wezterm.home_dir .. '/Projects/DC/dc-draw/dc-draw'

  local tab, fe_build_pane, window = mux.spawn_window {
    workspace = 'Q-Temp',
    cwd = project_dir,
  }
  tab:set_title('Build')

  local tab, git_pane, window = window:spawn_tab {
    cwd = project_dir,
  }
  tab:set_title('Git')

  local tab, fe_pane, window = window:spawn_tab {
    cwd = project_dir,
  }
  tab:set_title('Front-end')

  fe_build_pane:send_text 'yarn run dev\n'
  git_pane:send_text 'git status --porcelain\n'
  fe_pane:send_text 'nvim\n'

  mux.set_active_workspace 'Q-Temp'
end

local function create_switch_workspace(id)
  if id == 'timespace' then
    timespace_workspace()
  elseif id == 'pinepen' then
    pinepen_workspace()
  elseif id == 'kexxu-editor' then
    kex_front_workspace()
  elseif id == 'q-temp' then
    q_temp_workspace()
  end
end

function module.workspace_selector()
  return act.InputSelector {
    action = wezterm.action_callback(function(window, pane, id, label)
      if not id and not label then
        wezterm.log_info 'cancelled'
      else
        wezterm.log_info('you selected ', id, label)
        create_switch_workspace(id)
        -- pane:send_text(id)
        -- pane:split { size = 0.3 }

      end
    end),
    title = 'Choose Workspace',
    choices = {
      {
        label = 'Timespace',
        id = 'timespace',
      },
      {
        label = 'PinePen',
        id = 'pinepen',
      },
      {
        label = 'Kexxu-editor',
        id = 'kexxu-editor',
      },
      {
        label = 'Q-Temp',
        id = 'q-temp',
      },
    },
  }
end

return module
