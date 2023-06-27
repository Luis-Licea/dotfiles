# Nushell Config File
#
# version = 0.80.1

# For more information on defining custom themes, see
# https://www.nushell.sh/book/coloring_and_theming.html
# And here is the theme collection
# https://github.com/nushell/nu_scripts/tree/main/themes
let dark_theme = {
    # color for nushell primitives
    separator: white
    leading_trailing_space_bg: { attr: n } # no fg, no bg, attr none effectively turns this off
    header: green_bold
    empty: blue
    # Closures can be used to choose colors for specific values.
    # The value (in this case, a bool) is piped into the closure.
    bool: {|| if $in { 'light_cyan' } else { 'light_gray' } }
    int: white
    filesize: {|e|
      if $e == 0b {
        'white'
      } else if $e < 1mb {
        'cyan'
      } else { 'blue' }
    }
    duration: white
    date: {|| (date now) - $in |
      if $in < 1hr {
        'purple'
      } else if $in < 6hr {
        'red'
      } else if $in < 1day {
        'yellow'
      } else if $in < 3day {
        'green'
      } else if $in < 1wk {
        'light_green'
      } else if $in < 6wk {
        'cyan'
      } else if $in < 52wk {
        'blue'
      } else { 'dark_gray' }
    }
    range: white
    float: white
    string: white
    nothing: white
    binary: white
    cellpath: white
    row_index: green_bold
    record: white
    list: white
    block: white
    hints: dark_gray
    search_result: {bg: red fg: white}

    shape_and: purple_bold
    shape_binary: purple_bold
    shape_block: blue_bold
    shape_bool: light_cyan
    shape_closure: green_bold
    shape_custom: green
    shape_datetime: cyan_bold
    shape_directory: cyan
    shape_external: cyan
    shape_externalarg: green_bold
    shape_filepath: cyan
    shape_flag: blue_bold
    shape_float: purple_bold
    # shapes are used to change the cli syntax highlighting
    shape_garbage: { fg: white bg: red attr: b}
    shape_globpattern: cyan_bold
    shape_int: purple_bold
    shape_internalcall: cyan_bold
    shape_list: cyan_bold
    shape_literal: blue
    shape_match_pattern: green
    shape_matching_brackets: { attr: u }
    shape_nothing: light_cyan
    shape_operator: yellow
    shape_or: purple_bold
    shape_pipe: purple_bold
    shape_range: yellow_bold
    shape_record: cyan_bold
    shape_redirection: purple_bold
    shape_signature: green_bold
    shape_string: green
    shape_string_interpolation: cyan_bold
    shape_table: blue_bold
    shape_variable: purple
    shape_vardecl: purple
}

let light_theme = {
    # color for nushell primitives
    separator: dark_gray
    leading_trailing_space_bg: { attr: n } # no fg, no bg, attr none effectively turns this off
    header: green_bold
    empty: blue
    # Closures can be used to choose colors for specific values.
    # The value (in this case, a bool) is piped into the closure.
    bool: {|| if $in { 'dark_cyan' } else { 'dark_gray' } }
    int: dark_gray
    filesize: {|e|
      if $e == 0b {
        'dark_gray'
      } else if $e < 1mb {
        'cyan_bold'
      } else { 'blue_bold' }
    }
    duration: dark_gray
  date: {|| (date now) - $in |
    if $in < 1hr {
      'purple'
    } else if $in < 6hr {
      'red'
    } else if $in < 1day {
      'yellow'
    } else if $in < 3day {
      'green'
    } else if $in < 1wk {
      'light_green'
    } else if $in < 6wk {
      'cyan'
    } else if $in < 52wk {
      'blue'
    } else { 'dark_gray' }
  }
    range: dark_gray
    float: dark_gray
    string: dark_gray
    nothing: dark_gray
    binary: dark_gray
    cellpath: dark_gray
    row_index: green_bold
    record: white
    list: white
    block: white
    hints: dark_gray
    search_result: {fg: white bg: red}

    shape_and: purple_bold
    shape_binary: purple_bold
    shape_block: blue_bold
    shape_bool: light_cyan
    shape_closure: green_bold
    shape_custom: green
    shape_datetime: cyan_bold
    shape_directory: cyan
    shape_external: cyan
    shape_externalarg: green_bold
    shape_filepath: cyan
    shape_flag: blue_bold
    shape_float: purple_bold
    # shapes are used to change the cli syntax highlighting
    shape_garbage: { fg: white bg: red attr: b}
    shape_globpattern: cyan_bold
    shape_int: purple_bold
    shape_internalcall: cyan_bold
    shape_list: cyan_bold
    shape_literal: blue
    shape_match_pattern: green
    shape_matching_brackets: { attr: u }
    shape_nothing: light_cyan
    shape_operator: yellow
    shape_or: purple_bold
    shape_pipe: purple_bold
    shape_range: yellow_bold
    shape_record: cyan_bold
    shape_redirection: purple_bold
    shape_signature: green_bold
    shape_string: green
    shape_string_interpolation: cyan_bold
    shape_table: blue_bold
    shape_variable: purple
    shape_vardecl: purple
}

# External completer example
# let carapace_completer = {|spans|
#     carapace $spans.0 nushell $spans | from json
# }


# The default config record. This is where much of your global configuration is setup.
let-env config = {
  # true or false to enable or disable the welcome banner at startup
  show_banner: true
  ls: {
    use_ls_colors: true # use the LS_COLORS environment variable to colorize output
    clickable_links: true # enable or disable clickable links. Your terminal has to support links.
  }
  rm: {
    always_trash: false # always act as if -t was given. Can be overridden with -p
  }
  cd: {
    abbreviations: false # allows `cd s/o/f` to expand to `cd some/other/folder`
  }
  table: {
    mode: rounded # basic, compact, compact_double, light, thin, with_love, rounded, reinforced, heavy, none, other
    index_mode: always # "always" show indexes, "never" show indexes, "auto" = show indexes when a table has "index" column
    show_empty: true # show 'empty list' and 'empty record' placeholders for command output
    trim: {
      methodology: wrapping # wrapping or truncating
      wrapping_try_keep_words: true # A strategy used by the 'wrapping' methodology
      truncating_suffix: "..." # A suffix used by the 'truncating' methodology
    }
  }

  explore: {
    help_banner: true
    exit_esc: true

    command_bar_text: '#C4C9C6'
    # command_bar: {fg: '#C4C9C6' bg: '#223311' }

    status_bar_background: {fg: '#1D1F21' bg: '#C4C9C6' }
    # status_bar_text: {fg: '#C4C9C6' bg: '#223311' }

    highlight: {bg: 'yellow' fg: 'black' }

    status: {
      # warn: {bg: 'yellow', fg: 'blue'}
      # error: {bg: 'yellow', fg: 'blue'}
      # info: {bg: 'yellow', fg: 'blue'}
    }

    try: {
      # border_color: 'red'
      # highlighted_color: 'blue'

      # reactive: false
    }

    table: {
      split_line: '#404040'

      cursor: true

      line_index: true
      line_shift: true
      line_head_top: true
      line_head_bottom: true

      show_head: true
      show_index: true

      # selected_cell: {fg: 'white', bg: '#777777'}
      # selected_row: {fg: 'yellow', bg: '#C1C2A3'}
      # selected_column: blue

      # padding_column_right: 2
      # padding_column_left: 2

      # padding_index_left: 2
      # padding_index_right: 1
    }

    config: {
      cursor_color: {bg: 'yellow' fg: 'black' }

      # border_color: white
      # list_color: green
    }
  }

  history: {
    max_size: 10000 # Session has to be reloaded for this to take effect
    sync_on_enter: true # Enable to share history between multiple sessions, else you have to close the session to write history to file
    file_format: "plaintext" # "sqlite" or "plaintext"
    history_isolation: true # true enables history isolation, false disables it. true will allow the history to be isolated to the current session. false will allow the history to be shared across all sessions.
  }
  completions: {
    case_sensitive: false # set to true to enable case-sensitive completions
    quick: true  # set this to false to prevent auto-selecting completions when only one remains
    partial: true  # set this to false to prevent partial filling of the prompt
    algorithm: "prefix"  # prefix or fuzzy
    external: {
      enable: true # set to false to prevent nushell looking into $env.PATH to find more suggestions, `false` recommended for WSL users as this look up my be very slow
      max_results: 100 # setting it lower can improve completion performance at the cost of omitting some options
      completer: null # check 'carapace_completer' above as an example
    }
  }
  filesize: {
    metric: true # true => KB, MB, GB (ISO standard), false => KiB, MiB, GiB (Windows standard)
    format: "auto" # b, kb, kib, mb, mib, gb, gib, tb, tib, pb, pib, eb, eib, zb, zib, auto
  }
  cursor_shape: {
    emacs: line # block, underscore, line, blink_block, blink_underscore, blink_line (line is the default)
    vi_insert: block # block, underscore, line , blink_block, blink_underscore, blink_line (block is the default)
    vi_normal: underscore # block, underscore, line, blink_block, blink_underscore, blink_line (underscore is the default)
  }
  color_config: $dark_theme   # if you want a light theme, replace `$dark_theme` to `$light_theme`
  use_grid_icons: true
  footer_mode: "25" # always, never, number_of_rows, auto
  float_precision: 2 # the precision for displaying floats in tables
  # buffer_editor: "emacs" # command that will be used to edit the current line buffer with ctrl+o, if unset fallback to $env.EDITOR and $env.VISUAL
  use_ansi_coloring: true
  bracketed_paste: true # enable bracketed paste, currently useless on windows
  edit_mode: vi # emacs, vi
  shell_integration: true # enables terminal markers and a workaround to arrow keys stop working issue
  render_right_prompt_on_last_line: false # true or false to enable or disable right prompt to be rendered on last line of the prompt.

  hooks: {
    pre_prompt: [{||
      null  # replace with source code to run before the prompt is shown
    }]
    pre_execution: [{||
      null  # replace with source code to run before the repl input is run
    }]
    env_change: {
      PWD: [{|before, after|
        null  # replace with source code to run if the PWD environment is different since the last repl input
      }]
    }
    display_output: {||
      if (term size).columns >= 100 { table -e } else { table }
    }
    command_not_found: {||
      null  # replace with source code to return an error message when a command is not found
    }
  }
  menus: [
      # Configuration for default nushell menus
      # Note the lack of source parameter
      {
        name: completion_menu
        only_buffer_difference: false
        marker: "| "
        type: {
            layout: columnar
            columns: 4
            col_width: 20   # Optional value. If missing all the screen width is used to calculate column width
            col_padding: 2
        }
        style: {
            text: green
            selected_text: green_reverse
            description_text: yellow
        }
      }
      {
        name: history_menu
        only_buffer_difference: true
        marker: "? "
        type: {
            layout: list
            page_size: 10
        }
        style: {
            text: green
            selected_text: green_reverse
            description_text: yellow
        }
      }
      {
        name: help_menu
        only_buffer_difference: true
        marker: "? "
        type: {
            layout: description
            columns: 4
            col_width: 20   # Optional value. If missing all the screen width is used to calculate column width
            col_padding: 2
            selection_rows: 4
            description_rows: 10
        }
        style: {
            text: green
            selected_text: green_reverse
            description_text: yellow
        }
      }
      # Example of extra menus created using a nushell source
      # Use the source field to create a list of records that populates
      # the menu
      {
        name: commands_menu
        only_buffer_difference: false
        marker: "# "
        type: {
            layout: columnar
            columns: 4
            col_width: 20
            col_padding: 2
        }
        style: {
            text: green
            selected_text: green_reverse
            description_text: yellow
        }
        source: { |buffer, position|
            $nu.scope.commands
            | where name =~ $buffer
            | each { |it| {value: $it.name description: $it.usage} }
        }
      }
      {
        name: vars_menu
        only_buffer_difference: true
        marker: "# "
        type: {
            layout: list
            page_size: 10
        }
        style: {
            text: green
            selected_text: green_reverse
            description_text: yellow
        }
        source: { |buffer, position|
            $nu.scope.vars
            | where name =~ $buffer
            | sort-by name
            | each { |it| {value: $it.name description: $it.type} }
        }
      }
      {
        name: commands_with_description
        only_buffer_difference: true
        marker: "# "
        type: {
            layout: description
            columns: 4
            col_width: 20
            col_padding: 2
            selection_rows: 4
            description_rows: 10
        }
        style: {
            text: green
            selected_text: green_reverse
            description_text: yellow
        }
        source: { |buffer, position|
            $nu.scope.commands
            | where name =~ $buffer
            | each { |it| {value: $it.name description: $it.usage} }
        }
      }
  ]
  keybindings: [
    {
      name: completion_menu
      modifier: none
      keycode: tab
      mode: [emacs vi_normal vi_insert]
      event: {
        until: [
          { send: menu name: completion_menu }
          { send: menunext }
        ]
      }
    }
    {
      name: completion_previous
      modifier: shift
      keycode: backtab
      mode: [emacs, vi_normal, vi_insert] # Note: You can add the same keybinding to all modes by using a list
      event: { send: menuprevious }
    }
    {
      name: history_menu
      modifier: control
      keycode: char_r
      mode: emacs
      event: { send: menu name: history_menu }
    }
    {
      name: next_page
      modifier: control
      keycode: char_x
      mode: emacs
      event: { send: menupagenext }
    }
    {
      name: undo_or_previous_page
      modifier: control
      keycode: char_z
      mode: emacs
      event: {
        until: [
          { send: menupageprevious }
          { edit: undo }
        ]
       }
    }
    {
      name: yank
      modifier: control
      keycode: char_y
      mode: emacs
      event: {
        until: [
          {edit: pastecutbufferafter}
        ]
      }
    }
    {
      name: unix-line-discard
      modifier: control
      keycode: char_u
      mode: [emacs, vi_normal, vi_insert]
      event: {
        until: [
          {edit: cutfromlinestart}
        ]
      }
    }
    {
      name: kill-line
      modifier: control
      keycode: char_k
      mode: [emacs, vi_normal, vi_insert]
      event: {
        until: [
          {edit: cuttolineend}
        ]
      }
    }
    # Keybindings used to trigger the user defined menus
    {
      name: commands_menu
      modifier: control
      keycode: char_t
      mode: [emacs, vi_normal, vi_insert]
      event: { send: menu name: commands_menu }
    }
    {
      name: vars_menu
      modifier: alt
      keycode: char_o
      mode: [emacs, vi_normal, vi_insert]
      event: { send: menu name: vars_menu }
    }
    {
      name: commands_with_description
      modifier: control
      keycode: char_s
      mode: [emacs, vi_normal, vi_insert]
      event: { send: menu name: commands_with_description }
    }
  ]
}

################################################################################
# Preferred editor for local and remote sessions
################################################################################
if ($env.SSH_CONNECTION? | is-empty) {
    let-env EDITOR = nvim
} else {
    let executables = (which nvim vim vi nano emacs);
    let-env EDITOR = $executables.0.path?;
}
let-env VISUAL = $env.EDITOR;

let pagers = (which nvimpager most less);
let-env PAGER = $pagers.0.path;

################################################################################
# Ranger.
################################################################################
# Disable loading Ranger's global configuration files because custom
# configurations are provided.
let-env RANGER_LOAD_DEFAULT_RC = FALSE

################################################################################
# Lynx Browser.
################################################################################
let-env LYNX_CFG = $"($env.HOME)/.config/lynx/lynx.cfg"
let-env LYNX_LSS = $"($env.HOME)/.config/lynx/lynx.lss"

################################################################################
# Aliases.
################################################################################
alias alacrittyconfig = nvim ~/.config/alacritty/alacritty.yml
alias awesomeconfig = nvim ~/.config/awesome/rc.lua
alias bashconfig = nvim ~/.bashrc
alias cppmanconfig = nvim ~/.config/cppman/cppman.cfg
alias doomconfig = nvim ~/.config/doom/config.el
alias dwlconfig = nvim ~/.config/dwl/
alias emacsconfig = nvim ~/.config/doom/init.el
alias gitconfig = nvim ~/.config/git/config
alias lynxconfig = nvim .config/lynx/lynx.cfg
alias mostconfig = nvim ~/.config/mostrc
alias mpdconfig = nvim ~/.config/mpd/mpd.conf
alias mpvconfig = nvim ~/.config/mpv
alias ncmpcppconfig = nvim ~/.config/ncmpcpp/
alias neomuttconfig = nvim ~/.config/mutt/
alias neomuttmsmtpconfig = nvim ~/.config/msmtp/config
alias newsboatconfig = nvim ~/.config/newsboat/
alias nuconfig = nvim ~/.config/nushell/config.nu
alias nuconfigdir = nvim ~/.config/nushell
alias nvimconfig = nvim ~/.config/nvim/init.lua
alias nvimpagerconfig = nvim ~/.config/nvimpager/init.vim
alias nvimswap = cd ~/.local/share/nvim/swap/
alias picomconfig = nvim ~/.config/picom/picom.conf
alias qtileconfig = nvim ~/.config/qtile/config.py
alias rangercache = cd ~/.cache/ranger/
alias rangerconfig = nvim ~/.config/ranger/
alias roficonfig = nvim ~/.config/rofi/config.rasi
alias shellconfig = nvim ~/.bash_aliases
alias vimbconfig = nvim ~/.config/vimb/config
alias vscodiumconfig = nvim ~/.config/VSCodium/User/
alias waybarconfig = nvim ~/.config/waybar/
alias zathuraconfig = nvim ~/.config/zathura/zathurarc
alias zictconfig = nvim ~/.config/zict/zict.bash
alias zshconfig = nvim ~/.config/zsh/.zshrc

alias passconfig = cd $"($env.HOME)/.local/share/pass"
alias passbackup = cp -viur $"($env.HOME)/.local/share/pass/*" /run/user/1000/5bfbfc95be7243f8/primary/pass/
alias passrefresh = kdeconnect-cli --refresh
alias passdiff = diff -q -r $"($env.HOME)/.local/share/pass/" /run/user/1000/5bfbfc95be7243f8/primary/pass/

def say [words] {
    gtts-cli $words | mpv -
}

def scratchpad [path: string] {
    # Go to directory, open file, go to previous directory.
    cd /tmp
    nvim $path
    cd -
}

export extern "lf" [
    cd_or_select_path?: path, # set the initial dir or file selection to the given argument
    --command: string, # command to execute on client initialization
    --config: string, # path to the config file (instead of the usual paths)
    --cpuprofile: string, # path to the file to write the CPU profile
    --doc, # show documentation
    --last-dir-path: string, # path to the file to write the last dir on exit (to use for cd)
    --log: string, # path to the log file to write messages
    --memprofile: string, # path to the file to write the memory profile
    --remote: string, # send remote command to server
    --selection-path: string, # path to the file to write selected files on open (to use as open file dialog)
    --server, # start server (automatic)
    --single, # start a client without server
    --version, # show version
]

export extern "joshuto" [
    --version(-v), # prints the version
    --help(-h), # Prints help information
    --output-file: path, # the output file
    --path: path, # The path
]

alias awkscratch = scratchpad scratchpad.awk
alias bashscratch = scratchpad scratchpad.bash
alias confluencescratch = scratchpad scratchpad.confluencewiki
alias cppscratch = scratchpad scratchpad.cpp
alias cscratch = scratchpad scratchpad.c
alias elscratch = scratchpad scratchpad.el
alias groovyscratch = scratchpad scratchpad.groovy
alias javascratch = scratchpad scratchpad.java
alias luascratch = scratchpad scratchpad.lua
alias mdscratch = scratchpad scratchpad.md
alias nuscratch = scratchpad scratchpad.nu
alias pyscratch = scratchpad scratchpad.py
alias pyscratchtest = scratchpad scratchpad_test.py
alias sagescratch = scratchpad scratchpad.sage
alias typscratch = scratchpad scratchpad.typ
alias zshscratch = scratchpad scratchpad.zsh

def-env ranger-cd [] {
    let temporary_directory = (mktemp);
    try {
        ranger --choosedir $temporary_directory;
        cd (open $temporary_directory);
    } catch {
        print $in;
        print "An error happened while running Ranger.";
    }
    rm $temporary_directory;
}

def-env lf-cd [] {
    let temporary_directory = (mktemp);
    try {
        lf --last-dir-path $temporary_directory;
        cd (open $temporary_directory);
    } catch {
        print $in;
        print "An error happened while running lf.";
    }
    rm $temporary_directory;
}

def-env joshuto-cd [] {
    let temporary_directory = (mktemp);
    try {
        joshuto --output-file $temporary_directory;
    } catch {
    }
    try {
        cd (open $temporary_directory);
    } catch {
        print $in;
    }
    rm $temporary_directory;
}

alias bc = bc --mathlib
alias d = sdcv -u WordNet
alias de = sdcv -eu WordNet
alias e = exit
alias j = joshuto-cd
alias l = lf-cd
alias m = man -Hlynx
alias nr = setsid --fork alacritty -e nu -e ranger-cd
alias nt = setsid --fork alacritty
alias r = ranger-cd
alias t = sdcv -u "Moby Thesaurus II"
alias v = nvim

# Create a symlink to globally installed node modules for access to Mocha and Chai.
let setup_js_scratchpad = {
    cd /tmp;
    if not ('package.json' | path exists) {
        npm init -f | save --append /dev/null;
    }
    if not ('node_modules' | path exists) {
        let node_modules = $"($env.VOLTA_HOME)/tools/shared";
        ln -s $node_modules node_modules
    }
    if not ('.eslintrc.yml' | path exists) {
        ln -s ~/.config/nvim/templates/.eslintrc.yml .eslintrc.yml;
    }
    if not ('.prettierrc.yml' | path exists) {
        ln -s ~/.config/nvim/templates/.prettierrc.yml .prettierrc.yml;
    }
}

def jsscratch [] {
    do $setup_js_scratchpad;
    cd /tmp/;
    nvim scratchpad.mjs;
}

def jsscratchtest [] {
    do $setup_js_scratchpad;
    cd /tmp/;
    nvim scratchpad_test.mjs;
}

# # Create cargo project rather than individual file.
def rsscratch [] {
    cd /tmp;
    if not ('rsscratch' | path exists) {
        cargo new rsscratch;
    }
    nvim rsscratch/src/main.rs;

}

# Show icons along with files and directories.
alias lsdl = lsd -lah
alias lsdla = lsd -lAh
alias lsdll = lsd -lh
alias lsdtree = lsd --tree

# Add syntax highlighting to printed files.
alias bat = bat --style=plain --paging=never;
alias cat = bat;

alias codestatus = git-summary ~/Code -s
alias dotfiles = git --git-dir ~/.config/dotfiles/ --work-tree ~;
alias dotfilesui = gitui -d ~/.config/dotfiles/ -w ~;
alias passbgit = git --git-dir ~/.local/share/pass/.backup/.git --work-tree ~/.local/share/pass/.backup
alias passbgui = gitui -d ~/.local/share/pass/.backup/.git -w ~/.local/share/pass/.backup

# Export completions, functions, and aliases.
use ~/.config/nushell/modules/git-completions.nu *;
use ~/.config/nushell/modules/ranger.nu *;
# Dictionary aliases.
alias en = zict alter en
alias es = zict alter es
alias ja = zict alter ja
alias ru = zict alter ru
alias it = zict it
alias ру = zict alter ru

alias cheat = cht.sh
alias gdiff = git diff origin/master HEAD
# alias lf = ~/Code/lfimg/lfrun
alias locksway = swaylock -i /usr/share/backgrounds/suckless-wallpapers/nord_hills.png
alias lockx = xscreensaver-command -lock
alias man = man -a
alias mpvh = mpv --config-dir=~/.config/mpv/base
alias playmusic =  mpv /run/media/luis/DATA/Music/* --shuffle
alias rgf = rg --files
alias rsyncdelete = rsync -arv --delete
alias rsyncdryrun = rsync -arvn --delete
alias y = yt-dlp --write-thumbnail --extract-audio --sub-langs "en.*,ja,es,ru" --write-subs --audio-format mp3 --paths ~/Music
alias yd = yt-dlp --write-thumbnail --extract-audio --sub-langs "en.*,ja,es,ru" --write-subs --audio-format mp3 --paths
alias zathurah = zathura --config-dir=~/.config/zathura/base

# XDG-Ninja.
alias wget = wget --hsts-file=$"($env.XDG_DATA_HOME)/wget-hsts"

# https://unix.stackexchange.com/questions/79112/how-do-i-set-time-and-date-from-the-internet
# sudo ntpd -qg; sudo hwclock -w
# alias fixtime='sudo ntpd -qg'
# export bgs='/usr/share/backgrounds/nordic-wallpapers/'

# Only enter SSH password once.
# keychain --quiet --eval id_rsa > /dev/null

################################################################################
# packer.nu
################################################################################
# Load packer API.
overlay use ~/.local/share/nushell/packer/start/packer.nu/api_layer/packer_api.nu
# Load packages.
overlay use ~/.local/share/nushell/packer/packer_packages.nu
# Load conditional packages.
overlay use ~/.local/share/nushell/packer/conditional_packages.nu
