from IPython import get_ipython
from prompt_toolkit.filters import EmacsInsertMode, ViInsertMode
from prompt_toolkit.key_binding.bindings.named_commands import get_by_name
from prompt_toolkit.keys import Keys

ip = get_ipython()
insert_mode = ViInsertMode() | EmacsInsertMode()

# Register the shortcut if IPython is using prompt_toolkit
if getattr(ip, 'pt_cli', None):
    registry = ip.pt_cli.application.key_bindings_registry
    handle = registry.add_binding

    handle(Keys.ControlA, filter=insert_mode)(get_by_name('beginning-of-line'))
    handle(Keys.ControlE, filter=insert_mode)(get_by_name('end-of-line'))
    handle(Keys.ControlB, filter=insert_mode)(get_by_name('backward-char'))
    handle(Keys.ControlF, filter=insert_mode)(get_by_name('forward-char'))
    #  handle(Keys.Escape, 'b', filter=insert_mode)(get_by_name('backward-word'))
    #  handle(Keys.Escape, 'f', filter=insert_mode)(get_by_name('forward-word'))
    handle(Keys.ControlK, filter=insert_mode)(get_by_name('kill-line'))
    handle(Keys.ControlY, filter=insert_mode)(get_by_name('yank'))
    handle(
        Keys.ControlW, filter=insert_mode)(get_by_name('backward-kill-word'))

    handle(Keys.ControlP)(get_by_name('previous-history'))
    handle(Keys.ControlN)(get_by_name('next-history'))
