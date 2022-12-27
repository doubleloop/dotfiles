from IPython import get_ipython
from prompt_toolkit.filters import EmacsInsertMode, ViInsertMode
from prompt_toolkit.key_binding.bindings.named_commands import get_by_name
from prompt_toolkit.keys import Keys

ip = get_ipython()
insert_mode = ViInsertMode() | EmacsInsertMode()


def register(registry):
    handle = registry.add_binding

    handle(Keys.ControlK)(get_by_name('menu-complete-backward'))
    handle(Keys.ControlJ)(get_by_name('menu-complete'))


# Register the shortcut if IPython is using prompt_toolkit
registry = None
try:
    if hasattr(ip, 'pt_app'):
        registry = ip.pt_app.key_bindings
    elif hasattr(ip, 'pt_cli'):
        registry = ip.pt_cli.application.key_bindings_registry
except AttributeError:
    pass

if registry is not None:
    register(registry)
