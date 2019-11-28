# Autogenerated config.py
# Documentation:
#   qute://help/configuring.html
#   qute://help/settings.html

# Uncomment this to still load settings configured via autoconfig.yml
# config.load_autoconfig()

# Aliases for commands. The keys of the given dictionary are the
# aliases, while the values are the commands they map to.
# Type: Dict
c.aliases = {
    'q': 'close',
    'qa': 'quit',
    'w': 'session-save',
    'wq': 'quit --save'
}

# Require a confirmation before quitting the application.
# Type: ConfirmQuit
# Valid values:
#   - always: Always show a confirmation.
#   - multiple-tabs: Show a confirmation if multiple tabs are opened.
#   - downloads: Show a confirmation if downloads are running
#   - never: Never show a confirmation.
c.confirm_quit = ['never']

# Load a restored tab as soon as it takes focus.
# Type: Bool
c.session.lazy_restore = False

# Additional arguments to pass to Qt, without leading `--`. With
# QtWebEngine, some Chromium arguments (see
# https://peter.sh/experiments/chromium-command-line-switches/ for a
# list) will work.
# Type: List of String
c.qt.args = ['ppapi-widevine-path=/usr/lib/chromium/libwidevinecdmadapter.so']

# Always restore open sites when qutebrowser is reopened.
# Type: Bool
c.auto_save.session = True

# Automatically start playing `<video>` elements. Note: On Qt < 5.11,
# this option needs a restart and does not support URL patterns.
# Type: Bool
c.content.autoplay = False

# Which cookies to accept.
# Type: String
# Valid values:
#   - all: Accept all cookies.
#   - no-3rdparty: Accept cookies from the same origin only. This is known to break some sites, such as GMail.
#   - no-unknown-3rdparty: Accept cookies from the same origin only, unless a cookie is already set for the domain. On QtWebEngine, this is the same as no-3rdparty.
#   - never: Don't accept cookies at all.
c.content.cookies.accept = 'all'

# Allow websites to request geolocations.
# Type: BoolAsk
# Valid values:
#   - true
#   - false
#   - ask
config.set('content.geolocation', False, '*')

# Enable JavaScript.
# Type: Bool
config.set('content.javascript.enabled', True, 'file://*')

# Enable JavaScript.
# Type: Bool
config.set('content.javascript.enabled', True, 'chrome://*/*')

# Enable JavaScript.
# Type: Bool
config.set('content.javascript.enabled', True, 'qute://*/*')

# Allow pdf.js to view PDF files in the browser. Note that the files can
# still be downloaded by clicking the download button in the pdf.js
# viewer.
# Type: Bool
c.content.pdfjs = False

# Allow websites to register protocol handlers via
# `navigator.registerProtocolHandler`.
# Type: BoolAsk
# Valid values:
#   - true
#   - false
#   - ask
config.set('content.register_protocol_handler', True, 'calendar.google.com')

# Allow websites to register protocol handlers via
# `navigator.registerProtocolHandler`.
# Type: BoolAsk
# Valid values:
#   - true
#   - false
#   - ask
config.set('content.register_protocol_handler', True, 'mail.google.com')

# When to show the autocompletion window.
# Type: String
# Valid values:
#   - always: Whenever a completion is available.
#   - auto: Whenever a completion is requested.
#   - never: Never.
c.completion.show = 'always'

# Execute the best-matching command on a partial match.
# Type: Bool
c.completion.use_best_match = False

# Directory to save downloads to. If unset, a sensible OS-specific
# default is used.
# Type: Directory
c.downloads.location.directory = '~/downloads'

# Prompt the user for the download location. If set to false,
# `downloads.location.directory` will be used.
# Type: Bool
c.downloads.location.prompt = False

# Remember the last used download directory.
# Type: Bool
c.downloads.location.remember = True

# Which categories to show (in which order) in the :open completion.
# Type: FlagList
# Valid values:
#   - searchengines
#   - quickmarks
#   - bookmarks
#   - history
c.completion.open_categories = ['quickmarks', 'bookmarks', 'history']

# Default program used to open downloads. If null, the default internal
# handler is used. Any `{}` in the string will be expanded to the
# filename, else the filename will be appended.
# Type: String
c.downloads.open_dispatcher = 'xdg-open'

# Where to show the downloaded files.
# Type: VerticalPosition
# Valid values:
#   - top
#   - bottom
c.downloads.position = 'bottom'

# Characters used for hint strings.
# Type: UniqueCharString
c.hints.chars = 'sadfjklewcmpgh'

# Make characters in hint strings uppercase.
# Type: Bool
c.hints.uppercase = True

# Duration (in milliseconds) to show messages in the statusbar for. Set
# to 0 to never clear messages.
# Type: Int
c.messages.timeout = 5000

# When to show the scrollbar.
# Type: String
# Valid values:
#   - always: Always show the scrollbar.
#   - never: Never show the scrollbar.
#   - when-searching: Show the scrollbar when searching for text in the webpage. With the QtWebKit backend, this is equal to `never`.
c.scrolling.bar = 'always'

# Enable smooth scrolling for web pages. Note smooth scrolling does not
# work with the `:scroll-px` command.
# Type: Bool
c.scrolling.smooth = True

# Languages to use for spell checking. You can check for available
# languages and install dictionaries using scripts/dictcli.py. Run the
# script with -h/--help for instructions.
# Type: List of String
# Valid values:
#   - af-ZA: Afrikaans (South Africa)
#   - bg-BG: Bulgarian (Bulgaria)
#   - ca-ES: Catalan (Spain)
#   - cs-CZ: Czech (Czech Republic)
#   - da-DK: Danish (Denmark)
#   - de-DE: German (Germany)
#   - el-GR: Greek (Greece)
#   - en-AU: English (Australia)
#   - en-CA: English (Canada)
#   - en-GB: English (United Kingdom)
#   - en-US: English (United States)
#   - es-ES: Spanish (Spain)
#   - et-EE: Estonian (Estonia)
#   - fa-IR: Farsi (Iran)
#   - fo-FO: Faroese (Faroe Islands)
#   - fr-FR: French (France)
#   - he-IL: Hebrew (Israel)
#   - hi-IN: Hindi (India)
#   - hr-HR: Croatian (Croatia)
#   - hu-HU: Hungarian (Hungary)
#   - id-ID: Indonesian (Indonesia)
#   - it-IT: Italian (Italy)
#   - ko: Korean
#   - lt-LT: Lithuanian (Lithuania)
#   - lv-LV: Latvian (Latvia)
#   - nb-NO: Norwegian (Norway)
#   - nl-NL: Dutch (Netherlands)
#   - pl-PL: Polish (Poland)
#   - pt-BR: Portuguese (Brazil)
#   - pt-PT: Portuguese (Portugal)
#   - ro-RO: Romanian (Romania)
#   - ru-RU: Russian (Russia)
#   - sh: Serbo-Croatian
#   - sk-SK: Slovak (Slovakia)
#   - sl-SI: Slovenian (Slovenia)
#   - sq: Albanian
#   - sr: Serbian
#   - sv-SE: Swedish (Sweden)
#   - ta-IN: Tamil (India)
#   - tg-TG: Tajik (Tajikistan)
#   - tr-TR: Turkish (Turkey)
#   - uk-UA: Ukrainian (Ukraine)
#   - vi-VN: Vietnamese (Viet Nam)
c.spellcheck.languages = ['en-US', 'pl-PL']

# Open new tabs (middleclick/ctrl+click) in the background.
# Type: Bool
c.tabs.background = True

# Switch between tabs using the mouse wheel.
# Type: Bool
c.tabs.mousewheel_switching = False

# Width (in pixels) of the progress indicator (0 to disable).
# Type: Int
c.tabs.indicator.width = 0

# Search engines which can be used via the address bar. Maps a search
# engine name (such as `DEFAULT`, or `ddg`) to a URL with a `{}`
# placeholder. The placeholder will be replaced by the search term, use
# `{{` and `}}` for literal `{`/`}` signs. The search engine named
# `DEFAULT` is used when `url.auto_search` is turned on and something
# else than a URL was entered to be opened. Other search engines can be
# used by prepending the search engine name to the search term, e.g.
# `:open google qutebrowser`.
# Type: Dict
c.url.searchengines = {
    'DEFAULT': 'https://www.google.com/search?q={}',
    'd': 'https://duckduckgo.com/?q={}',
    'g': 'https://www.google.com/search?q={}',
    'gh': 'https://github.com/search?q={}',
    'i': 'https://www.google.com/search?tbm=isch&q={}',
    'im': 'http://www.imdb.com/find?s=all&q={}',
    'm': 'https://www.google.com/maps?q={}',
    'w': 'http://en.wikipedia.org/wiki/Special:Search?search={}',
    'y': 'http://www.youtube.com/results?search_query={}',
    'gr': 'https://www.goodreads.com/search?q={}',
    'a': 'https://allegro.pl/listing?string={}',
    'deb': 'https://packages.debian.org/search?suite=bullseye&section=all&arch=any&searchon=names&keywords={}',
    'k': 'https://keras.io/search.html?q={}',
    'py': 'https://docs.python.org/3/search.html?q={}',
    'pypi': 'https://pypi.org/search/?q={}',
    'c': 'https://www.cht.sh/{}',
    'l': 'https://www.last.fm/search?q={}'
}

# Hide the window decoration.  This setting requires a restart on
# Wayland.
# Type: Bool
c.window.hide_decoration = True

# This setting can be used to map keys to other keys. When the key used
# as dictionary-key is pressed, the binding for the key used as
# dictionary-value is invoked instead. This is useful for global
# remappings of keys, for example to map Ctrl-[ to Escape. Note that
# when a key is bound (via `bindings.default` or `bindings.commands`),
# the mapping is ignored.
# Type: Dict
c.bindings.key_mappings = {}

# Bindings for normal mode
config.bind(',M', 'hint links spawn totem --enqueue {hint-url}')
config.bind(',m', 'spawn totem --enqueue {url}')
config.bind('<Alt+n>', 'tab-next')
config.bind('<Alt+p>', 'tab-prev')
config.bind('<Alt+q>', 'tab-focus last')
config.bind('<Ctrl+6>', 'tab-focus last')
config.bind('<Ctrl+r>', 'reload')
config.unbind('<Ctrl+w>')
config.bind('B', 'set-cmd-text -s :bookmark-load -t')
config.bind('J', 'tab-prev')
config.bind('K', 'tab-next')
config.bind('b', 'set-cmd-text -s :bookmark-load')
config.unbind('d')
config.bind('dc', 'download-clear')
config.bind('dd', 'download-delete')
config.bind('do', 'download-open')
config.bind('t', 'open -t')
config.bind('x', 'tab-close')
config.bind('gw', 'set-cmd-text -s :tab-give ')
# Bindings for command mode
config.bind('<Alt+n>', 'completion-item-focus --history next', mode='command')
config.bind('<Alt+p>', 'completion-item-focus --history prev', mode='command')
config.bind('<Ctrl+n>', 'completion-item-focus next', mode='command')
config.bind('<Ctrl+p>', 'completion-item-focus prev', mode='command')
