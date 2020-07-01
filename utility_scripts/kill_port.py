#!/bin/python3

# Takes a port number and kills process listening on the port

import argparse
import os
import subprocess
import sys

def get_port_number():
    parser = argparse.ArgumentParser(description = 'Take a port number as an argument and kill the process listening on the port')
    parser.add_argument('port_number', type=int, help='Port number (1024 - 65535)')
    port_number = parser.parse_args().port_number
    return port_number

def check_port_number(port_number):
    # Check if the port number entered is viable and check that there is a process running on the port
    if port_number < 1024 or port_number > 65535:
        print(f'Error, the port number entered ({port_number}) is outside of the range of acceptable port numbers (1024 - 65535)')
        sys.exit(1)

def kill_process_for_port(port_number):
    lsof = subprocess.run(['lsof', '-n', f'-i4TCP:%s' % port_number], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    lsof = lsof.stdout.decode()
    if 'LISTEN' in lsof:
        pid = int(lsof.split()[10])
        try:
            os.kill(pid, 9)
        except:
            print(f'Failed to kill listening process with pid {pid}')
            sys.exit(1)
        else:
            print(f'Process with pid {pid} has been successfully killed.')
    else:
        print(f'Could not find a process listening on port {port_number}')


if __name__ == '__main__':
    port_number = get_port_number()
    check_port_number(port_number)
    kill_process_for_port(port_number)
