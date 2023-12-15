{pkgs, ...}: let
  colors = ''
    # vim: set ft=neomuttrc:

    color normal        color254        default
    color error         color160        default
    color tilde         color235        default
    color message       color37         default
    color markers       color160        default
    color attachment    color254        default
    color search        color61         default
    color indicator     white           color237
    color tree          color136        default

    mono  bold          bold
    mono  underline     underline
    mono  indicator     reverse
    mono  error         bold
    # index ----------------------------------------------------------------

    color index         color160        default       "~D(!~p|~p)"               # deleted
    color index         color235        default       ~F                         # flagged
    color index         color166        default       ~=                         # duplicate messages
    color index         color140        default       "~A!~N!~T!~p!~Q!~F!~D!~P"  # the rest
    #color index         J_base          default       "~A~N!~T!~p!~Q!~F!~D"      # the rest, new
    color index         color160        default       "~A"                        # all messages
    color index         color166        default       "~E"                        # expired messages
    color index         color33         default       "~N"                        # new messages
    color index         color33         default       "~O"                        # old messages
    color index         color61         default       "~Q"                        # messages that have been replied to
    color index         color252        default       "~R"                        # read messages
    color index         color33         default       "~U"                        # unread messages
    color index         color33         default       "~U~$"                      # unread, unreferenced messages
    color index         color141        default       "~v"                        # messages part of a collapsed thread
    color index         color141        default       "~P"                        # messages from me
    color index         color37         default       "~p!~F"                     # messages to me
    color index         color37         default       "~N~p!~F"                   # new messages to me
    color index         color37         default       "~U~p!~F"                   # unread messages to me
    color index         color252        default       "~R~p!~F"                   # messages to me
    color index         color160        default       "~F"                        # flagged messages
    color index         color160        default       "~F~p"                      # flagged messages to me
    color index         color160        default       "~N~F"                      # new flagged messages
    color index         color160        default       "~N~F~p"                    # new flagged messages to me
    color index         color160        default       "~U~F~p"                    # new flagged messages to me
    color index         color235        color160        "~D"                        # deleted messages
    color index         color245        default       "~v~(!~N)"                  # collapsed thread with no unread
    color index         color136        default       "~v~(~N)"                   # collapsed thread with some unread
    color index         color64         default       "~N~v~(~N)"                 # collapsed thread with unread parent
    # statusbg used to indicated flagged when foreground color shows other status
    # for collapsed thread
    color index         color160        color235        "~v~(~F)!~N"                # collapsed thread with flagged, no unread
    color index         color136        color235        "~v~(~F~N)"                 # collapsed thread with some unread & flagged
    color index         color64         color235        "~N~v~(~F~N)"               # collapsed thread with unread parent & flagged
    color index         color64         color235        "~N~v~(~F)"                 # collapsed thread with unread parent, no unread inside, but some flagged
    color index         color37         color235        "~v~(~p)"                   # collapsed thread with unread parent, no unread inside, some to me directly
    color index         color136        color160        "~v~(~D)"                   # thread with deleted (doesn't differentiate between all or partial)
    #color index         color136        color234        "~(~N)"                    # messages in threads with some unread
    #color index         color64         color234        "~S"                       # superseded messages
    color index         color136        default        "~T"                       # tagged messages
    #color index         color166        color160        "~="                       # duplicated messages
    color index_author color32 default '.*'
    color index_date color214 default
    color index_size color28 default

    # message headers ------------------------------------------------------

    color header        color251        default       "^"
    color hdrdefault    color251        default
    color header        color214        default       "^(Date)"
    color header        color251        default       "^(From)"
    color header        color39         default       "^(Subject)"

    # body -----------------------------------------------------------------

    color quoted        color31         default
    color quoted1       color37         default
    color quoted2       color136        default
    color quoted3       color160        default
    color quoted4       color166        default

    color signature     color240        default
    color bold          color235        default
    color underline     color235        default
    color normal        color250        default
    #
    color body          color245        default       "[;:][-o][)/(|]"    # emoticons
    color body          color245        default       "[;:][)(|]"         # emoticons
    color body          color245        default       "[*]?((N)?ACK|CU|LOL|SCNR|BRB|BTW|CWYL|\
                                                         |FWIW|vbg|GD&R|HTH|HTHBE|IMHO|IMNSHO|\
                                                         |IRL|RTFM|ROTFL|ROFL|YMMV)[*]?"
    color body          color245        default       "[ ][*][^*]*[*][ ]?" # more emoticon?
    color body          color245        default       "[ ]?[*][^*]*[*][ ]" # more emoticon?

    ## pgp

    color body          color160        default       "(BAD signature)"
    color body          color37         default       "(Good signature)"
    color body          color234        default       "^gpg: Good signature .*"
    color body          color241        default       "^gpg: "
    color body          color241        color160        "^gpg: BAD signature from.*"
    mono  body          bold                            "^gpg: Good signature"
    mono  body          bold                            "^gpg: BAD signature from.*"

    # yes, an insance URL regex
    color body          color33        default        "([a-z][a-z0-9+-]*://(((([a-z0-9_.!~*'();:&=+$,-]|%[0-9a-f][0-9a-f])*@)?((([a-z0-9]([a-z0-9-]*[a-z0-9])?)\\.)*([a-z]([a-z0-9-]*[a-z0-9])?)\\.?|[0-9]+\\.[0-9]+\\.[0-9]+\\.[0-9]+)(:[0-9]+)?)|([a-z0-9_.!~*'()$,;:@&=+-]|%[0-9a-f][0-9a-f])+)(/([a-z0-9_.!~*'():@&=+$,-]|%[0-9a-f][0-9a-f])*(;([a-z0-9_.!~*'():@&=+$,-]|%[0-9a-f][0-9a-f])*)*(/([a-z0-9_.!~*'():@&=+$,-]|%[0-9a-f][0-9a-f])*(;([a-z0-9_.!~*'():@&=+$,-]|%[0-9a-f][0-9a-f])*)*)*)?(\\?([a-z0-9_.!~*'();/?:@&=+$,-]|%[0-9a-f][0-9a-f])*)?(#([a-z0-9_.!~*'();/?:@&=+$,-]|%[0-9a-f][0-9a-f])*)?|(www|ftp)\\.(([a-z0-9]([a-z0-9-]*[a-z0-9])?)\\.)*([a-z]([a-z0-9-]*[a-z0-9])?)\\.?(:[0-9]+)?(/([-a-z0-9_.!~*'():@&=+$,]|%[0-9a-f][0-9a-f])*(;([-a-z0-9_.!~*'():@&=+$,]|%[0-9a-f][0-9a-f])*)*(/([-a-z0-9_.!~*'():@&=+$,]|%[0-9a-f][0-9a-f])*(;([-a-z0-9_.!~*'():@&=+$,]|%[0-9a-f][0-9a-f])*)*)*)?(\\?([-a-z0-9_.!~*'();/?:@&=+$,]|%[0-9a-f][0-9a-f])*)?(#([-a-z0-9_.!~*'();/?:@&=+$,]|%[0-9a-f][0-9a-f])*)?)[^].,:;!)? \t\r\n<>\"]"
    # and a heavy handed email regex
    #color body          J_magent        color234        "((@(([0-9a-z-]+\\.)*[0-9a-z-]+\\.?|#[0-9]+|\\[[0-9]?[0-9]?[0-9]\\.[0-9]?[0-9]?[0-9]\\.[0-9]?[0-9]?[0-9]\\.[0-9]?[0-9]?[0-9]\\]),)*@(([0-9a-z-]+\\.)*[0-9a-z-]+\\.?|#[0-9]+|\\[[0-9]?[0-9]?[0-9]\\.[0-9]?[0-9]?[0-9]\\.[0-9]?[0-9]?[0-9]\\.[0-9]?[0-9]?[0-9]\\]):)?[0-9a-z_.+%$-]+@(([0-9a-z-]+\\.)*[0-9a-z-]+\\.?|#[0-9]+|\\[[0-2]?[0-9]?[0-9]\\.[0-2]?[0-9]?[0-9]\\.[0-2]?[0-9]?[0-9]\\.[0-2]?[0-9]?[0-9]\\])"

    # Various smilies and the like
    color body          color230        default       "<[Gg]>"                            # <g>
    color body          color230        default       "<[Bb][Gg]>"                        # <bg>
    color body          color136        default       " [;:]-*[})>{(<|]"                  # :-) etc...
    # *bold*
    color body          color33         default       "(^|[[:space:][:punct:]])\\*[^*]+\\*([[:space:][:punct:]]|$)"
    mono  body          bold                            "(^|[[:space:][:punct:]])\\*[^*]+\\*([[:space:][:punct:]]|$)"
    # _underline_
    color body          color33         default       "(^|[[:space:][:punct:]])_[^_]+_([[:space:][:punct:]]|$)"
    mono  body          underline                       "(^|[[:space:][:punct:]])_[^_]+_([[:space:][:punct:]]|$)"
    # /italic/  (Sometimes gets directory names)
    color body         color33         default       "(^|[[:space:][:punct:]])/[^/]+/([[:space:][:punct:]]|$)"
    mono body          underline                       "(^|[[:space:][:punct:]])/[^/]+/([[:space:][:punct:]]|$)"

    # Border lines.
    color body          color33         default       "( *[-+=#*~_]){6,}"

    #folder-hook .                  "color status        J_black         J_status        "
    #folder-hook gmail/inbox        "color status        J_black         color136        "
    #folder-hook gmail/important    "color status        J_black         color136        "

    # Sidebar
    color sidebar_new color33 default
    color sidebar_flagged color160 default
    # set sidebar_format = "%B%?F? [%F]?%* %?N?%N/?%S"
    color progress white color237
  '';
  colors2 = ''
    # NeoMutt color file
    # Maintainer: szorfein <szorfein@protonmail.com>
    # URL: https://github.com/szorfein/dotfiles
    # Last Change: 2019 June 02
    # Version: 0.1

    color normal            default default
    color indicator         white      black
    color status            brightgreen black
    color tree              brightred   default
    color signature         color102    default
    color message           color253    default
    color attachment        color117    default
    color error             color240    default
    color tilde             color130    default

    color search       color100     default
    color markers      color138     default

    color quoted        cyan default
    color quoted1       yellow black
    color quoted2       red black
    color quoted3       green black
    color quoted4       cyan black
    color quoted5       yellow black
    color quoted6       red black
    color quoted7       green black
    color quoted8       brightblack black
    color quoted9       brightred black

    # color body          cyan  default  "((ftp|http|https)://|news:)[^ >)\"\t]+"
    color body          cyan  default  "[-a-z_0-9.+]+@[-a-z_0-9.]+"
    # color body          red   default  "(^| )\\*[-a-z0-9*]+\\*[,.?]?[ \n]"
    # color body          green default  "(^| )_[-a-z0-9_]+_[,.?]?[\n]"
    # color body          red   default  "(^| )\\*[-a-z0-9*]+\\*[,.?]?[ \n]"
    # color body          green default  "(^| )_[-a-z0-9_]+_[,.?]?[ \n]"

    # Index
    color index color202 color8 ~F         # Flagged
    color index color39 color8 ~O
    color index color229 color22 ~T         # Tagged
    color index color240 color8 ~D         # Deleted
    #color index brightblue default "~N" # NEW
    #color index magenta default "~U" # UNREAD
    #color index white default "~R" # READ

    # URL
    color body brightgreen black "(http|ftp|news|telnet|finger)://[^ \"\t\r\n]*"
    color body brightgreen black "mailto:[-a-z_0-9.]+@[-a-z_0-9.]+"
    mono body bold "(http|ftp|news|telnet|finger)://[^ \"\t\r\n]*"
    mono body bold "mailto:[-a-z_0-9.]+@[-a-z_0-9.]+"

    # Email address
    color body brightgreen black "[-a-z_0-9.%$]+@[-a-z_0-9.]+\\.[-a-z][-a-z]+"

    #mono body      reverse         '^(subject):.*'
    #color body     brightwhite magenta     '^(subject):.*'
    #mono body      reverse         '[[:alpha:]][[:alnum:]-]+:'
    #color body     black cyan      '[[:alpha:]][[:alnum:]-]+:'

    # --- header ---

    color hdrdefault        color30         black
    color header            magenta        black    '^date:'
    color header            color153        black    '^(to|cc|bcc):'
    color header cyan black '^from:'
    color header brightyellow black '^subject:'
    color header            color31         black    '^user-agent:'
    color header            color29         black    '^reply-to:'

    #color header   magenta default '^(status|lines|date|received|sender|references):'
    #color header   magenta default '^(pr|mime|x-|user|return|content-)[^:]*:'
    #color header   brightyellow default '^content-type:'
    #color header   magenta default '^content-type: *text/plain'
    # color header  brightgreen default '^list-[^:]*:'
    #mono  header    bold               '^(subject):.*$'
    #color header   brightcyan default      '^(disposition)'
    #color header   green default   '^(mail-)?followup'
    #color header   white default   '^reply'
    #color header   brightwhite default     '^(resent)'
    # color header  brightwhite default     '^from:'

    mono index     bold '~h "^content-type: *(multipart/(mixed|signed|encrypted)|application/)"'
    color index    red black '~h "^content-type: *multipart/(signed|encrypted)"'

    #color sidebar_new color39 color8

    # Credits to https://github.com/sheoak/neomutt-powerline-nerdfonts/
    set index_format=" %T %{!%d %b} %1M %-28.28L  %?X?&·? %s"
    set pager_format=" %n  %T %s%*  %{!%d %b · %H:%M} %?X?  %X ? %P  "
    set status_format = " %f%?r? %r?   %m %?n?  %n ?  %?d?  %d ?%?t?  %t ?%?F?  %F? %> %?p?   %p ?"
    #set vfolder_format = " %N %?n?%3n&   ?  %8m  · %f"
    set attach_format = "%u%D  %T%-75.75d %?T?%&   ? %5s · %m/%M"

    # no addressed to me, to me, group, cc, sent by me, mailing list
    # set to_chars=""
    # unchanged mailbox, changed, read only, attach mode
    set status_chars = " "

    set hidden_tags = "unread,draft,flagged,passed,replied,attachment,signed,encrypted"
    tag-transforms "replied" "↻ "  \
        "encrytpted" "" \
        "signed" "" \
        "attachment" "" \

    # The formats must start with 'G' and the entire sequence is case sensitive.
    tag-formats "replied" "GR" \
        "encrypted" "GE" \
        "signed" "GS" \
        "attachment" "GA" \

    # powerline status bar hack
    color status white black
    color status green black ''
    color status yellow black ''
    color status red black ''
    color status brightwhite blue '(.*)' 1 # bottom left
    color status blue black '.*()' 1
    color status brightwhite blue '\s* [0-9]+\s*' # bottom right
    color status blue black '().*$' 1
    color status yellow black '()\s*\s*[0-9]+\s*' 1
    color status black yellow '\s*\s*[0-9]+\s*'
    color status blue yellow '() ([0-9]+%|all|end) \s*' 1
    color status black blue ' ([0-9]+%|all|end) \s*'
    color status yellow black '()\s*' 1
    color status default black ''

    # Colors
    # cancel theme colors
    color index color13 color8 ~Q
    color index color13 color8 ~P
    color index color13 color8 ~T
    color index color13 color8 ~O
    color index color1 color8 ~F

    # add some nice custom coloring to the message list
    # thanks to new neomutt features
    # http://www.mutt.org/doc/manual/#patterns
    # https://neomutt.org/feature/index-color
    color index_subject color109 color8 "~P !~T !~D"
    color index_author color109 color8 "~P !~T !~D"
    color index_subject color243 color8 "~Q !~T !~D"
    color index_author color243 color8 "~Q !~T !~D"

    # new message
    color index cyan black ~N
    color index_subject cyan black "~N !~T !~D"
    color index_author  cyan black "~N !~T !~D"

    color index_subject color142 color8 "~O !~T !~D"
    color index_author color142 color8 "~O !~T !~D"
    color index_subject color214 color8 "~F !~T !~D"
    color index_author color214 color8 "~F !~T !~D"
    color index_subject brightcolor214 color8 "~F ~N !~T !~D"
    color index_author  brightcolor214 color8 "~F ~N !~T !~D"
    color index_subject color167 color8 "~= !~T !~D"
    color index_author color167 color8 "~= !~T !~D"
    color index_subject brightcolor109 color8 "~P ~N !~T !~D"
    color index_author brightcolor109 color8 "~P ~N !~T !~D"
    color index color8 color223 "~T"
    color index color229 color124 "~D"
  '';
  keymaps = ''
    # vim: set filetype=neomuttrc:

    bind index,pager \CP sidebar-prev                 # Ctrl-n to select next folder
    bind index,pager \CN sidebar-next                 # Ctrl-p to select previous folder
    bind index,pager \CI sidebar-open                 # Ctrl-o to open selected folder
    bind index,pager \CB sidebar-toggle-visible       # Ctrl-b to toggle visibility of the sidebar

    macro index A \
        "<tag-pattern>~N<enter><tag-prefix><clear-flag>N<untag-pattern>.<enter>" \
        "mark all new as read"

    bind index j next-entry
    bind index k previous-entry
    bind pager j next-line
    bind pager k previous-line

    bind attach,pager J next-entry
    bind attach,pager K previous-entry

    bind attach,index,pager \CD next-page
    bind attach,index,pager \CU previous-page
    bind pager g top
    bind pager G bottom
    bind attach,index g first-entry
    bind attach,index G last-entry

    bind editor <Tab> complete-query

    # open attachments with mailcap with <return>
    bind attach <return> view-mailcap
    # save attachments to a folder
    macro attach s '<save-entry> <bol>~/Downloads<eol>' 'save attachment'
  '';
  options = ''
    # vim: set filetype=neomuttrc:

    # Where to put the stuff
    set header_cache = "~/.cache/mutt/headers"
    set message_cachedir = "~/.cache/mutt/bodies"
    set certificate_file = "~/.cache/mutt/certificates"

    set mailcap_path = "~/.config/neomutt/mailcap"
    set editor = "$EDITOR"

    # settings
    set pager_index_lines = 8
    set pager_context = 5                # show 3 lines of context
    set pager_stop                       # stop at end of message
    set menu_scroll                      # scroll menu
    set smart_wrap
    set tilde                            # use ~ to pad mutt
    set move=no                          # don't move messages when marking as read
    set mail_check = 30                  # check for new mail every 30 seconds
    set imap_keepalive = 900             # 15 minutes
    set sleep_time = 0                   # don't sleep when idle
    set wait_key = no		     # mutt won't ask "press key to continue"
    set envelope_from                    # which from?
    set edit_headers                     # show headers when composing
    set fast_reply                       # skip to compose when replying
    set askcc                            # ask for CC:
    set fcc_attach                       # save attachments with the body
    set forward_format = "Fwd: %s"       # format of subject when forwarding
    set forward_decode                   # decode when forwarding
    set forward_quote                    # include message in forwards
    set mime_forward                     # forward attachments as part of body
    set attribution = "On %d, %n wrote:" # format of quoting header
    set reply_to                         # reply to Reply to: field
    set reverse_name                     # reply as whomever it was to
    set include                          # include message in replies
    set text_flowed=yes                  # correct indentation for plain text
    set beep_new             # bell on new mails
    set pipe_decode          # strip headers and eval mimes when piping
    set thorough_search      # strip headers and eval mimes before searching
    unset sig_dashes                     # no dashes before sig
    unset markers

    # sort/threading
    # Sort by newest conversation first.
    set charset = "utf-8"
    set uncollapse_jump
    set sort_re
    set sort = reverse-threads
    set sort_aux = last-date-received

    # set sort     = threads
    # set sort_aux = reverse-last-date-received
    # How we reply and quote emails.

    set reply_regexp = "^(([Rr][Ee]?(\[[0-9]+\])?: *)?(\[[^]]+\] *)?)*"
    set quote_regexp = "^( {0,4}[>|:#%]| {0,4}[a-z0-9]+[>|]+)+"
    set send_charset = "utf-8:iso-8859-1:us-ascii" # send in utf-8

    #sidebar
    set sidebar_visible # comment to disable sidebar by default
    set sidebar_short_path
    set sidebar_folder_indent
    set sidebar_format = "%B %* [%?N?%N / ?%S]"
    set mail_check_stats

    auto_view text/html text/calendar application/ics # view html automatically
    alternative_order text/enriched text/plain text/html text/*

    set index_format="%3C %Z %[!%m.%d.%y] %-19.19n %?X?(%1X)& ? %?M?(%02M)& ? %s%> %?y?[%Y]?"
    set index_format="%Z %3C %{%b %d} %-17.17n (%5c) %s"
    set index_format="%3C %Z %{%b %d} %-19.19n (%5c) %?X?(%1X)& ? %?M?(%02M)& ? %s%> %?y?[%Y]?"

    # Use GPGME
    # Use my key for signing and encrypting
    set pgp_default_key = 279B8000BC8B5D1D85A1D023A61FAA4F918A6092

    # Use GPGME
    set crypt_use_gpgme = yes

    # Automatically sign all out-going email
    set crypt_autosign = yes

    # Sign replies to signed emails
    set crypt_replysign = yes

    # Encrypt replies to encrypted emails
    set crypt_replyencrypt = yes

    # Encrypt and sign replies to encrypted and signed email
    set crypt_replysignencrypted = yes

    # Attempt to verify signatures automatically
    set crypt_verify_sig = yes

    # So you can view encrypted emails automatically
    auto_view application/pgp-encrypted

    # Attempt to encrypt automatically, if possible
    # I would recommend setting this to no as university often have spam filters
    # And this will cause your emails to be marked as spam
    # as they can't decrypt your emails LMAO
    set crypt_opportunistic_encrypt = no
  '';
  config = ''
    ######################
    #  General Options  #
    ######################

    set editor="vim -c 'set syntax=mail ft=mail enc=utf-8'"

    ignore *
    unignore from: to: cc: date: subject:
    hdr_order from: to: cc: date: subject:
    set index_format="%4C %Z %{%b %d} %-16.16L  %s"

    set pager_stop
    set pager_index_lines = 4
    set pager_context = 2
    set markers = no           # Don't mark wrapper lines
    set delete = yes           # Don't ask

    unset wait_key

    set mail_check = 0

    # Disable features
    unset confirmappend
    unset copy
    unset metoo                # Remove me from CC headers.
    set move = no              # Don't use mbox
    set nohelp                 # No help line.
    set pager_index_lines = 0
    unset mark_old
    unset sort_re
    unset use_from
    unset use_domain
    unset user_agent
    unset record
    set nobeep      # Shup up. ;-)

    ##################
    #  Key Bindings  #
    ##################

    # Vi Key Bindings
    bind attach,browser,index g noop
    bind attach,browser,index gg first-entry
    bind attach,browser,index G last-entry
    bind pager g noop
    bind pager gg top
    bind pager G bottom
    bind pager k previous-line
    bind pager j next-line

    bind attach,browser,pager,index \CF next-page
    bind attach,browser,pager,index \CB previous-page
    bind attach,browser,pager,index \Cu half-up
    bind attach,browser,pager,index \Cd half-down
    bind browser,pager \Ce next-line
    bind browser,pager \Cy previous-line
    bind index \Ce next-line
    bind index \Cy previous-line

    bind pager,index d noop
    bind pager,index dd delete-message

    # menu for encryp or not a mail when compose
    bind compose p pgp-menu

    #########
    #  GPG  #
    #########

    setenv PINENTRY_USER_DATA curses
    set crypt_use_gpgme = yes

    # Capability key [C]
    set pgp_default_key = 0x9CC9729A2E369CB3
    # sign key [S]
    set pgp_sign_as = 0xFD696BDDAA8FDC50
    # encrypt key [E]
    set pgp_self_encrypt_as = 0xE2ADD2080A6B28AE

    set pipe_decode # Decode messages I pipe to commands, typically to patch
    set crypt_autosign
    set crypt_replyencrypt
    set crypt_replysignencrypted
    set crypt_verify_sig

    # copy file from /usr/share/doc/mutt/samples/gpg.rc
    #source ~/.neomutt/gpg.rc

    # Status bar
    set status_chars=" *%A"
    #set status_format="───[ Folder: %f ]───[%r%m messages%?n? (%n new)?%?d? (%d to delete)?%?t? (%t tagged)? ]───%>─%?p?( %p postponed )?───"

    # Index view
    set sort=threads
    set sort_aux=reverse-last-date-received
    set uncollapse_jump
    set strict_threads
    set thorough_search

    ##########################
    #  Compose view options  #
    ##########################

    set askcc         # Ask for CC:
    set edit_headers  # I want to edit the headers.
    set envelope_from
    set fast_reply
    set forward_format = "Fwd: %s"
    set forward_quote
    set include
    set hidden_host
    set menu_scroll
    set mime_forward = ask-no
    set reply_to
    set reverse_name
    set tilde

    # Colors
    source ~/.neomutt/colors

    ##################
    #  Mutt Sidebar  #
    ##################

    set sidebar_visible
    set sidebar_folder_indent
    set sidebar_short_path

    # Toggle sidebar visible with b
    macro index b '<enter-command>toggle sidebar_visible<enter><refresh>'
    macro pager b '<enter-command>toggle sidebar_visible<enter><redraw-screen>'

    # Uncomment these if sidebar patch is installed
    bind index,pager \CP sidebar-prev # Ctrl-n to select next folder
    bind index,pager \CN sidebar-next # Ctrl-p to select previous folder
    bind index,pager \CO sidebar-open # Ctrl-o to open selected folder

    #######################
    #  IMAP: offlineimap  #
    #######################

    set mbox_type = Maildir
    set folder    = ~/.mails/gmail
    set spoolfile = "+INBOX"
    set record    = ""
    set postponed = "+[Gmail].Drafts"
    set trash     = "+[Gmail].Trash"

    set mailcap_path = ~/.neomutt/mailcap # filetypes, w3m for html, etc

    # Mailboxes
    source ~/.neomutt/mailboxes

    #################
    #  SMTP: msmtp  #
    #################

    ## Additional config set in ~/.msmtprc
    set sendmail_wait = -1
    set send_charset="utf-8"
    set sendmail="/usr/bin/msmtp"

    # Default account
    folder-hook gmail/* source ~/.neomutt/accounts/gmail
  '';
  config2 = ''
    # vim: filetype=muttrc
    #
    # General rebindings
    bind attach <return> view-mailcap
    bind attach l view-mailcap
    bind editor <space> noop
    bind pager c imap-fetch-mail
    bind index G last-entry
    bind index g noop
    bind index gg first-entry
    bind pager,attach h exit
    bind pager j next-line
    bind pager k previous-line
    bind pager l view-attachments
    bind index j next-entry
    bind index k previous-entry
    bind index D delete-message
    bind index U undelete-message
    bind index L limit
    bind index h noop
    bind index l display-message
    bind browser h goto-parent
    bind browser l select-entry
    bind pager,browser gg top-page
    bind pager,browser G bottom-page
    bind attach,index,pager \CD next-page
    bind attach,index,pager \CU previous-page
    bind index,pager,browser d half-down
    bind index,pager,browser u half-up
    bind index,pager R group-reply
    bind index \031 previous-undeleted	# Mouse wheel
    bind index \005 next-undeleted		# Mouse wheel
    bind pager \031 previous-line		# Mouse wheel
    bind pager \005 next-line		# Mouse wheel

    # sidebar mappings
    bind index,pager \Ck sidebar-prev
    bind index,pager \Cj sidebar-next
    bind index,pager \Co sidebar-open
    bind index,pager \Cp sidebar-prev-new
    bind index,pager \Cn sidebar-next-new
    bind index,pager B sidebar-toggle-visible

    # global index and pager shortcuts
    bind index,pager @ compose-to-sender
    bind index,pager D purge-message
    bind index <tab> sync-mailbox
    bind index <space> collapse-thread

    # Email completion bindings
    bind editor <Tab> complete-query
    bind editor ^T complete

    # Press A to mark all new emails in the index as read
    macro index A \
        "<tag-pattern>~N<enter><tag-prefix><clear-flag>N<untag-pattern>.<enter>" \
        "mark all new as read"

    # Press C to add contact to Khard address book
    macro index,pager C \
        "<pipe-message>khard add-email<return>" \
        "add the sender email address to khard"

    # Press Ctrl-b to scan for urls with urlscan
    macro index,pager \Cb \
        "<pipe-message> urlscan<enter>" \
        "call urlscan to extract URLs out of a message"
    macro attach,compose \Cb \
        "<pipe-entry> urlscan<enter>" \
        "call urlscan to extract URLs out of a message"

    ## Shortcuts
    macro index,pager <f2> '<sync-mailbox><enter-command>source ~/.config/neomutt/accounts/gmail<enter><change-folder>!<enter>'
    macro index,pager <f3> '<sync-mailbox><enter-command>source ~/.config/neomutt/accounts/cruzio<enter><change-folder>!<enter>'
    macro index,pager <f4> '<sync-mailbox><enter-command>source ~/.config/neomutt/accounts/main<enter><change-folder>!<enter>'
    macro index,pager I <change-newsgroup>?
  '';
  sort = {
    date = "date";
    date_received = "date-received";
    from = "from";
    mailbox_order = "mailbox-order";
    score = "score";
    size = "size";
    spam = "spam";
    subject = "subject";
    threads = "threads";
    to = "to";
  };
  mapping = {
    alias = "alias";
    attach = "attach";
    browser = "browser";
    compose = "compose";
    editor = "editor";
    generic = "generic";
    index = "index";
    mix = "mix";
    pager = "pager";
    pgp = "pgp";
    postpone = "postpone";
    query = "query";
    smime = "smime";
  };
in {
  programs = {
    mbsync.enable = true;
    msmtp.enable = true;
    notmuch = {
      enable = true;
      hooks = {
        preNew = "mbsync --all";
      };
    };
    neomutt = {
      enable = true;
      vimKeys = true;
      sort = sort.date_received;
      checkStatsInterval = 60;
      sidebar = {
        enable = true;
        shortPath = true;
        width = 25;
        # format = "%D %?S?[%N/%S]?";
      };
      settings = {
        mailcap_path = "$HOME/.config/neomutt/mailcap:$MAILCAP_PATH";
        # sort_aux = "reverse-last-date-received";
        # wait_key = "no";
        # timeout = "3";
        # mail_check = "0";
        # mail_check_stats = "yes";
        # mark_old = "no";
      };
      extraConfig = colors;
      # macros = [
      #   {
      #     map = ["index"];
      #     key = "o";
      #     action = "<shell-escape>mbsync -a -q &<enter>";
      #   }
      #   {
      #     map = ["index" "pager"];
      #     key = "B";
      #     action = "<pipe-message> ${pkgs.urlscan}/bin/urlscan<Enter>";
      #   }
      #   {
      #     map = ["attach" "compose"];
      #     key = "B";
      #     action = "<pipe-entry> ${pkgs.urlscan}/bin/urlscan<Enter>";
      #   }
      # ];

      binds = with mapping; [
        {
          map = [attach pager];
          key = "J";
          action = "next-entry";
        }
        {
          map = [attach pager];
          key = "K";
          action = "previous-entry";
        }
        #   {
        #     map = ["index" "pager"];
        #     key = "<tab>";
        #     action = "sync-mailbox";
        #   }
        #   {
        #     map = ["index" "pager"];
        #     key = "R";
        #     action = "group-reply";
        #   }
        #   {
        #     map = ["index" "pager"];
        #     key = "<down>";
        #     action = "sidebar-next";
        #   }
        #   {
        #     map = ["index" "pager"];
        #     key = "<up>";
        #     action = "sidebar-prev";
        #   }
        #   {
        #     map = ["index" "pager"];
        #     key = "<right>";
        #     action = "sidebar-open";
        #   }
      ];
    };
  };

  home = with pkgs; {
    packages = [librewolf zathura qview];
    file.".config/neomutt/mailcap".text = with lib; ''
      text/plain; cat %s; copiousoutput
      text/html; ${getExe' librewolf "librewolf"} &>/dev/null '%s' &; nametemplate=%s.html
      video/mp4; ${getExe mpv} %s
      application/pdf; ${getExe zathura} %s
      application/pdf:pdf; ${getExe zathura} %s
      image/*; ${getExe' qview "qview"} %s 2>/dev/null
    '';
  };
}
