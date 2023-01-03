-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = "alacritty"
editor = os.getenv("EDITOR") or "nvim"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod1"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    -- awful.layout.suit.floating,
    awful.layout.suit.tile,
    -- awful.layout.suit.tile.left,
    -- awful.layout.suit.tile.bottom,
    -- awful.layout.suit.tile.top,
    -- awful.layout.suit.fair,
    -- awful.layout.suit.fair.horizontal,
    -- awful.layout.suit.spiral,
    -- awful.layout.suit.spiral.dwindle,
    -- awful.layout.suit.max,
    -- awful.layout.suit.max.fullscreen,
    -- awful.layout.suit.magnifier,
    -- awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
}
-- }}}

-- {{{ Menu
-- Create a launcher widget and a main menu
myawesomemenu = {
   { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", function() awesome.quit() end },
}

mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
                                    { "open terminal", terminal }
                                  }
                        })

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- {{{ Wibar
-- Create a textclock widget
mytextclock = wibox.widget.textclock(" %a, %b %e | %m-%d-%Y | %l:%M %p ")

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
                    awful.button({ }, 1, function(t) t:view_only() end),
                    awful.button({ modkey }, 1, function(t)
                                              if client.focus then
                                                  client.focus:move_to_tag(t)
                                              end
                                          end),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, function(t)
                                              if client.focus then
                                                  client.focus:toggle_tag(t)
                                              end
                                          end),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
                )

local tasklist_buttons = gears.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  c:emit_signal(
                                                      "request::activate",
                                                      "tasklist",
                                                      {raise = true}
                                                  )
                                              end
                                          end),
                     awful.button({ }, 3, function()
                                              awful.menu.client_list({ theme = { width = 250 } })
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                          end))

--- Get absolute path to random wallpaper from the given directories.
---@vararg string The paths to the directories storing wallpapers.
---@return string
function GetRandomWallpaper(...)
    -- The absolute path to all wallpapers.
    local wallpapers = {}

    -- For each wallpaper directory:
    for _, dir in ipairs({...}) do
        -- Get the file names separated by newlines.
        local handle = assert(io.popen(
            'find ' .. dir .. ' -type f -maxdepth 1  -printf "%f\n"', 'r'))
        local output = assert(handle:read('*a'))
        handle:close()

        -- Get all characters in each line.
        local lines = output:gmatch('(.-)[\n\r]')

        -- Store the wallpaper names.
        for line in lines do table.insert(wallpapers, dir .. '/' .. line) end
    end

    -- Set seed before calling random(), which does not work after a refresh.
    math.randomseed(os.time())

    -- Get a random index in the range of the wallpaper array.
    local wallpaper_idx = math.random(#wallpapers)

    -- Get a random wallpaper from the list.
    return wallpapers[wallpaper_idx]
end

-- beautiful.wallpaper = awful.util.get_configuration_dir() .. "path/to/wallpaper.png"
beautiful.wallpaper = GetRandomWallpaper(
    os.getenv('HOME') .. '/Pictures/wallpapers/nordic/'
)

local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)

    -- Each screen has its own tag table.
    awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons
    }

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons
    }

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            mylauncher,
            s.mytaglist,
            s.mypromptbox,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            mykeyboardlayout,
            wibox.widget.systray(),
            mytextclock,
            s.mylayoutbox,
        },
    }
end)
-- }}}

-- {{{ Mouse bindings
root.buttons(gears.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end)
    -- Forward/backward tag scrolling.
    -- awful.button({ }, 4, awful.tag.viewnext),
    -- awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- Use `xev` to get the key codes.
local keys = {
    q = "#24",
    w = "#25",
    e = "#26",
    r = "#27",
    t = "#28",
    y = "#29",
    u = "#30",
    i = "#31",
    o = "#32",
    p = "#33",

    a = "#38",
    s = "#39",
    d = "#40",
    f = "#41",
    g = "#42",
    h = "#43",
    j = "#44",
    k = "#45",
    l = "#46",

    z = "#52",
    x = "#53",
    c = "#54",
    v = "#55",
    b = "#56",
    n = "#57",
    m = "#58",
}

-- {{{ Key bindings
globalkeys = gears.table.join(
    awful.key({ modkey,           }, keys.s,      hotkeys_popup.show_help,
              {description="show help", group="awesome"}),
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
              {description = "go back", group = "tag"}),

    awful.key({ modkey,           }, keys.j,
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key({ modkey,           }, keys.k,
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
    ),
    awful.key({ modkey,           }, keys.w, function () mymainmenu:show() end,
              {description = "show main menu", group = "awesome"}),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, keys.j, function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, keys.k, function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "client"}),
    awful.key({ modkey, "Control" }, keys.j, function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({ modkey, "Control" }, keys.k, function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),
    awful.key({ modkey,           }, keys.u, awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}),

    -- Standard program
    awful.key({ modkey, "Shift"   }, "Return", function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey, "Control" }, keys.r, awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Shift"   }, keys.q, awesome.quit,
              {description = "quit awesome", group = "awesome"}),

    awful.key({ modkey,           }, keys.l,     function () awful.tag.incmwfact( 0.05)          end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ modkey,           }, keys.h,     function () awful.tag.incmwfact(-0.05)          end,
              {description = "decrease master width factor", group = "layout"}),
    awful.key({ modkey, "Shift"   }, keys.h,     function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),
    awful.key({ modkey, "Shift"   }, keys.l,     function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ modkey, "Control" }, keys.h,     function () awful.tag.incncol( 1, nil, true)    end,
              {description = "increase the number of columns", group = "layout"}),
    awful.key({ modkey, "Control" }, keys.l,     function () awful.tag.incncol(-1, nil, true)    end,
              {description = "decrease the number of columns", group = "layout"}),
    awful.key({ modkey,           }, "space", function () awful.layout.inc( 1)                end,
              {description = "select next", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
              {description = "select previous", group = "layout"}),

    awful.key({ modkey, "Control" }, "n",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                    c:emit_signal(
                        "request::activate", "key.unminimize", {raise = true}
                    )
                  end
              end,
              {description = "restore minimized", group = "client"}),

    -- Prompt
    awful.key({ modkey },            keys.r,     function () awful.screen.focused().mypromptbox:run() end,
              {description = "run prompt", group = "launcher"}),

    awful.key({ modkey }, keys.x,
              function ()
                  awful.prompt.run {
                    prompt       = "Run Lua code: ",
                    textbox      = awful.screen.focused().mypromptbox.widget,
                    exe_callback = awful.util.eval,
                    history_path = awful.util.get_cache_dir() .. "/history_eval"
                  }
              end,
              {description = "lua execute prompt", group = "awesome"}),
    -- Menu bar
    -- awful.key({ modkey }, "p", function() menubar.show() end,
              -- {description = "show the menu bar", group = "launcher"}),
    -- Execute Rofi if it is available!
    awful.key({ modkey, }, keys.p, function()
            awful.spawn.with_shell("rofi -show run -show-icons -disable-history")
        end, {description = "run programs", group = "launcher"}),
    awful.key({ modkey, "Shift"}, keys.p, function()
            awful.spawn.with_shell("rofi -show drun -show-icons -disable-history")
        end, {description = "show the menubar", group = "launcher"}),
    -- Custom Show/hide statusbar
    awful.key({ modkey }, keys.b,
        function ()
            myscreen = awful.screen.focused()
            myscreen.mywibox.visible = not myscreen.mywibox.visible
        end,
    {description = "toggle statusbar", group = "awesome"})
)

-- Commands for changing volume.
local volume = {
    raise = "amixer -D pulse sset Master 5%+",
    lower = "amixer -D pulse sset Master 5%-",
    toggle = "amixer sset Master toggle",
}

-- Commands for controlling music and video players.
local playerctl = {
    play = "rofi_playerctl play-pause",
    prev = "rofi_playerctl previous",
    next = "rofi_playerctl next",
    pick = "rofi_playerctl",
}

clientkeys = gears.table.join(
    -- awful.key({ modkey,           }, "f",
        -- function (c)
            -- c.fullscreen = not c.fullscreen
            -- c:raise()
        -- end,
        -- {description = "toggle fullscreen", group = "client"}),
    awful.key({ modkey, "Shift"    }, keys.f,
        function (c)
            if awful.layout.getname() == "fullscreen" then
                awful.layout.set(awful.layout.suit.tile)
            else
                awful.layout.set(awful.layout.suit.max.fullscreen)
            end
        end,
        {description = "toggle fullscreen", group = "layout"}),
    awful.key({ modkey, "Shift"   }, keys.c,      function (c) c:kill()                         end,
              {description = "close", group = "client"}),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ,
              {description = "toggle floating", group = "client"}),
    awful.key({ modkey,           }, keys.o,      function (c) c:move_to_screen()               end,
              {description = "move to screen", group = "client"}),
    -- Custom
    awful.key({ modkey,           }, "Return", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"}),
    awful.key({ modkey,           }, "e",
        function()
            client.focus = awful.client.getmaster(); client.focus:raise()
        end,
        {description = "focus master window", group = "client"}),
    awful.key({ modkey,           }, keys.f,
        function (c)
            if awful.layout.getname() == "floating" then
                awful.layout.set(awful.layout.suit.tile)
            else
                awful.layout.set(awful.layout.suit.floating)
            end
        end,
        {description = "toggle floating", group = "layout"}),
    awful.key({ modkey, "Control" }, keys.t, function (c) awful.titlebar.toggle(c) end,
        {description = "toggle title bar", group = 'client'}),
    awful.key({ modkey, "Shift"}, keys.t,      function (c) c.ontop = not c.ontop            end,
              {description = "toggle keep on top", group = "client"}),
    -- awful.key({ modkey,           }, "n",
        -- function (c)
            -- -- The client currently has the input focus, so it cannot be
            -- -- minimized, since minimized clients can't have the focus.
            -- c.minimized = true
        -- end ,
        -- {description = "minimize", group = "client"}),
    -- awful.key({ modkey,           }, "m",
        -- function (c)
            -- c.maximized = not c.maximized
            -- c:raise()
        -- end ,
        -- {description = "(un)maximize", group = "client"}),
    awful.key({ modkey,           }, keys.m,
        function (c)
            if awful.layout.getname() == "max" then
                awful.layout.set(awful.layout.suit.tile)
            else
                awful.layout.set(awful.layout.suit.max)
            end
        end,
        {description = "toggle maximize", group = "layout"}),
    -- awful.key({ modkey, "Control" }, "m",
        -- function (c)
            -- c.maximized_vertical = not c.maximized_vertical
            -- c:raise()
        -- end ,
        -- {description = "(un)maximize vertically", group = "client"}),
    -- awful.key({ modkey, "Shift"   }, "m",
        -- function (c)
            -- c.maximized_horizontal = not c.maximized_horizontal
            -- c:raise()
        -- end ,
        -- {description = "(un)maximize horizontally", group = "client"}),

    -- Custom multimedia keys:
    awful.key({ }, "XF86AudioPrev",
        function () awful.util.spawn(playerctl.prev) end,
        {description = "Audio Prev", group = "system"}),

    awful.key({ }, "XF86AudioPlay",
        function () awful.util.spawn(playerctl.play) end,
        {description = "Audo Play", group = "system"}),

    awful.key({ }, "XF86AudioNext",
        function () awful.util.spawn(playerctl.next) end,
        {description = "Audio Next", group = "system"}),

    awful.key({ }, "XF86AudioMute",
        function () awful.util.spawn(volume.toggle) end,
        {description = "Toggle volume", group = "system"}),

    awful.key({ }, "XF86AudioLowerVolume",
        function () awful.util.spawn(volume.lower) end,
        {description = "Lower volume", group = "system"}),

    awful.key({ }, "XF86AudioRaiseVolume",
        function () awful.util.spawn(volume.raise) end,
        {description = "Raise volume", group = "system"}),

    -- Custom: This may change for every keyboard!
    awful.key({ "Mod4" }, "F5",
        function () awful.util.spawn(playerctl.pick) end,
        {description = "Audio Pick", group = "system"}),

    awful.key({ "Mod4" }, "F6",
        function () awful.util.spawn(playerctl.prev) end,
        {description = "Audio Prev", group = "system"}),

    awful.key({ "Mod4" }, "F7",
        function () awful.util.spawn(playerctl.play) end,
        {description = "Audo Play", group = "system"}),

    awful.key({ "Mod4" }, "F8",
        function () awful.util.spawn(playerctl.next) end,
        {description = "Audio Next", group = "system"}),

    awful.key({ "Mod4" }, "F9",
        function () awful.util.spawn(volume.toggle) end,
        {description = "Toggle volume", group = "system"}),

    awful.key({ "Mod4" }, "F10",
        function () awful.util.spawn(volume.lower) end,
        {description = "Lower volume", group = "system"}),

    awful.key({ "Mod4" }, "F11",
        function () awful.util.spawn(volume.raise) end,
        {description = "Raise volume", group = "system"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end

clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ modkey }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen
     }
    },

    -- Floating clients.
    { rule_any = {
        instance = {
          "DTA",  -- Firefox addon DownThemAll.
          "copyq",  -- Includes session name in class.
          "pinentry",
        },
        class = {
          "Arandr",
          "Blueman-manager",
          "Gpick",
          "Kruler",
          "MessageWin",  -- kalarm.
          "Sxiv",
          "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
          "Wpa_gui",
          "veromix",
          "xtightvncviewer"},

        -- Note that the name property shown in xprop might be set slightly after creation of the client
        -- and the name shown there might not match defined rules here.
        name = {
          "Event Tester",  -- xev.
        },
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "ConfigManager",  -- Thunderbird's about:config.
          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        }
      }, properties = { floating = true }},

    -- Add titlebars to normal clients and dialogs
    { rule_any = {type = { "normal", "dialog" }
      }, properties = { titlebars_enabled = false }
    },

    -- Set Firefox to always map on the tag named "2" on screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { screen = 1, tag = "2" } },
}
-- }}}

-- {{{ Window swallowing.
function is_terminal(c)
    return (c.class and c.class:match("Alacritty")) and true or false
end

function copy_size(c, parent_client)
    if not c or not parent_client then return end
    if not c.valid or not parent_client.valid then return end

    c.x=parent_client.x;
    c.y=parent_client.y;
    c.width=parent_client.width;
    c.height=parent_client.height;
end

--- Return the parent process id.
---@param pid number The process id whose parent process id will be returned.
---@return number?
local function get_parent_pid(pid)
    local handle = io.popen("ps --format ppid='' --pid " .. pid)
    local result = handle:read("*a")
    handle:close()
    return tonumber(result)
end
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end

    -- {{{ Window swallowing.
    if is_terminal(c) or not c.pid then return end

    local parent_pid = get_parent_pid(c.pid)
    local grandparent_pid = get_parent_pid(parent_pid)
    local parent_client = awful.client.focus.history.get(c.screen, 1)

    if parent_client and (grandparent_pid == parent_client.pid or parent_pid == parent_client.pid) and is_terminal(parent_client) then
        parent_client.child_resize=c
        parent_client.minimized = true

        c:connect_signal("unmanage", function() parent_client.minimized = false end)

        -- c.floating=true
        copy_size(c, parent_client)
    end
    -- }}}
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = gears.table.join(
        awful.button({ }, 1, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c) : setup {
        { -- Left
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        { -- Middle
            { -- Title
                align  = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            awful.titlebar.widget.floatingbutton (c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.stickybutton   (c),
            awful.titlebar.widget.ontopbutton    (c),
            awful.titlebar.widget.closebutton    (c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

-- Custom gap:
-- beautiful.useless_gap = 5
-- Custom auto-start programs:
awful.spawn.with_shell("compton -i 0.7")
awful.spawn.with_shell("emacs --daemon")
awful.spawn.with_shell("gnome-keyring-daemon --daemonize")
-- awful.spawn.with_shell("xscreensaver --no-splash")
-- awful.spawn.with_shell("nitrogen --restore")

-- {{{ Disable status bar at startup.
myscreen = awful.screen.focused()
myscreen.mywibox.visible = not myscreen.mywibox.visible
-- }}}
