#!/usr/bin/env python3

import subprocess
subprocess.run(['cat /etc/redhat-release'], shell=True, check=True)
subprocess.run(['df -Th'], shell=True, check=True)

