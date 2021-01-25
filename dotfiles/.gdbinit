# use libraries from virtualenv (mainly gdbinit requirements)
python
import os,subprocess,sys
from pathlib import Path
paths = subprocess.check_output('. $WORKON_HOME/dbg/bin/activate && python -c "import os,sys;print(os.linesep.join(sys.path).strip())"',shell=True).decode("utf-8").split()
sys.path.extend(paths)

# sys.executable is never inside virtualenv (gdb uses libpythonXXX.so)
# ipython generates some warning because of this so this hack supress it
del os.environ["VIRTUAL_ENV"]
end

source ~/src/pwndbg/gdbinit.py

# Intel syntax is more readable
set disassembly-flavor intel

# When inspecting large portions of code the scrollbar works better than 'less'
# set pagination off

# Keep a history of all the commands typed. Search is possible using ctrl-r
set history save on
set history filename ~/.gdb_history
set history size 32768
# set history expansion on
# set follow-fork-mode child

