#!/usr/bin/env python3
import subprocess
from subprocess import call, run, Popen, PIPE, STDOUT
from pathlib import Path
from i3ipc import Connection

i3 = Connection()

def windownotify(i3, event):
    """Hide Polybar when in fullcsreen and display current window title."""
    result = run(['ps', '-aux'], stdout=PIPE).stdout.decode()
    if event.container.fullscreen_mode == 0 and 'i3-nagbar' not in result:
        call('polybar-msg cmd show'.split(' '))
    else:
        call('polybar-msg cmd hide'.split(' '))

    if event.change in "focus" "title":
        call('polybar-msg hook titlehook 1'.split(' '))

def kill_subl_license(i3, event):
    """Close Sublime license window."""
    if event.change in "new":
        script = f'{str(Path.home())}/.scripts/windows/kill_subl'
        license_win = run([script, '1'], stdout=PIPE).stdout.decode().rstrip()
        subl_win = run([script, '2'], stdout=PIPE).stdout.decode().rstrip()
        if license_win:
            print(f'subl3: license window id ({license_win})')
            run(f'i3-msg "[id={license_win}] kill"', shell=True, stdout=subprocess.DEVNULL)
            run(f'i3-msg "[id={subl_win}] focus"', shell=True, stdout=subprocess.DEVNULL)

def tabbed(i3, event):
    """Show window titles when tabbed."""
    i3_msg = run(['i3-msg', '-t', 'get_tree'], stdout=PIPE).stdout.decode()
    with open(f'{str(Path.home())}/.config/polybar/config') as f:
        data = ''.join(f.readlines())

    if i3_msg.find('tabbed') >= 0:
        if 'override-redirect = true' in data:
            run(["sed",
                 "-i",
                 "s/override-redirect = true/override-redirect = false/",
                 f"{str(Path.home())}/.config/polybar/config"])
            run(['i3-msg', 'reload'])
    elif 'override-redirect = false' in data:
        run(["sed",
             "-i",
             "s/override-redirect = false/override-redirect = true/",
             f"{str(Path.home())}/.config/polybar/config"])
        run(['i3-msg', 'reload'])

def reload_urxvtd(i3, event):
    """Reload urxvtd when the last urxvt window closes.

    For some reason, mondo doesn't update Xresources (terminal colors)
      when the last urxvt window closes. However, after restarting urxvtd,
      it works again.
    """
    if event.change in "close":
        wmctrl = run(['wmctrl', '-lx',], stdout=PIPE).stdout
        grep   = Popen(['grep', 'urxvt\.URxvt'], stdin=PIPE, stdout=PIPE)
        wc     = Popen(['wc', '-l'], stdout=PIPE, stdin=PIPE)

        grep_stdout = grep.communicate(input=wmctrl)[0]
        urxvt_count = wc.communicate(input=grep_stdout)[0].decode().rstrip()
        
        if int(urxvt_count) == 0:
            run(['sh', f'{str(Path.home())}/.scripts/windows/reload_urxvtd'])


i3.on('window', windownotify)
i3.on('window', kill_subl_license)
i3.on('window', tabbed)
i3.on('window', reload_urxvtd)
i3.main()
