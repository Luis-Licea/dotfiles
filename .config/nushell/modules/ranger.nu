#!/usr/bin/env nu

################################################################################
# Ranger.
################################################################################
# Disable loading Ranger's global configuration files because custom
# configurations are provided.
export-env { let-env RANGER_LOAD_DEFAULT_RC = FALSE }

export alias r = ranger-cd
export alias nr = setsid --fork alacritty -e nu -e ranger-cd

export def-env ranger-cd [] {
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

