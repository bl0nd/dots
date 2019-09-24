#!/usr/bin/env python3
# -*- coding: utf8 -*-

"""
bat.py

Switches polybar battery display based on the battery currently being used.
It will take the average of the 2 batteries.

Credit: kotajacob
"""

import os
import sys
import argparse
from contextlib import ExitStack


# Constants
AC   = '/sys/class/power_supply/AC'
BAT0 = '/sys/class/power_supply/BAT0'
BAT1 = '/sys/class/power_supply/BAT1'

def main():
    bat0 = ''
    bat1 = ''
    bat0Max = ''
    bat1Max = ''

    # Parser
    parser = argparse.ArgumentParser(description='Battery Status')
    parser.add_argument('-r', '--raw', action='store_true', help='Print battery percentage instead.')
    args = parser.parse_args()

    # AC
    with open(os.path.join(AC, 'online'), 'r') as f:
        ac = int(f.readline())

    for battery_num in range(2):
        for state in ['energy_full', 'energy_now', 'charge_full', 'charge_now']:
            try:
                with open(os.path.join(f'/sys/class/power_supply/BAT{battery_num}', state), 'r') as f:
                    if state.split('_')[1] == 'full':
                        if battery_num == 0:
                            bat0Max = f.readline()
                        else:
                            bat1Max = f.readline()
                    elif state.split('_')[1] == 'now':
                        if battery_num == 0:
                            bat0 = f.readline()
                        else:
                            bat1 = f.readline()
            except FileNotFoundError as e:
                pass

    # Check if battery values were found
    batteries = {}
    if bat0 or bat0Max:
        batteries["bat0"] = [int(bat0.rstrip()), int(bat0Max.rstrip())]
    if bat1 or bat1Max:
        batteries["bat1"] = [int(bat1.rstrip()), int(bat1Max.rstrip())]

    # Convert to %
    total_percent = sum([p[0] / p[1] * 100 for p in batteries.values()])
    current_percent = int(total_percent / len(batteries))

    with ExitStack() as stack:
        batfile='/sys/class/power_supply/{}/status'
        files = [stack.enter_context(open(batfile.format(fname.upper()))) for fname in batteries.keys()]
        charging = all(f.readline().strip() != 'Discharging' for f in files)

        if charging:
            if ac > 0:
                message = '%{F#ffcc66}%{F-} %{F#d9d7ce} ' + str(int(current_percent))
            else:
                if (current_percent <= 25):
                    message = '%{F#ffcc66}%{F-} %{F#d9d7ce} ' + str(current_percent)
                elif (current_percent > 25 and current_percent <= 50):
                    message = '%{F#ffcc66}%{F-} %{F#d9d7ce} ' + str(current_percent)
                elif (current_percent > 50 and current_percent <= 75):
                    message = '%{F#ffcc66}%{F-} %{F#d9d7ce} ' + str(current_percent)
                else:
                    message = '%{F#ffcc66}%{F-} %{F#d9d7ce} ' + str(current_percent)
        else:
            if ac > 0:
                message = '%{F#d9d7ce} ' + str(current_percent)
            else:
                if (current_percent <= 25):
                    message = '%{F#d9d7ce} ' + str(current_percent)
                elif (current_percent > 25 and current_percent <= 50):
                    message = '%{F#d9d7ce} ' + str(current_percent)
                elif (current_percent > 50 and current_percent <= 75):
                    message = '%{F#d9d7ce} ' + str(current_percent)
                else:
                    message = '%{F#d9d7ce} ' + str(current_percent)

    if args.raw:
        print(current_percent)
    else:
        print(message)

if __name__ == '__main__':
    main()
