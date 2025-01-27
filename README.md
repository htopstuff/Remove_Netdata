# Netdata Removal Script

## Overview

This script provides a comprehensive method to remove **Netdata** from a Linux server. It ensures the Netdata service is stopped, uninstalled, and all associated files, directories, users, and groups are removed. The script is for use after installing the WordOps stack when you want to remove Netdata.

## Features

- Stops the Netdata service.
- Disables the Netdata service.
- Completely uninstalls Netdata using the package manager.
- Removes all residual configuration files and directories related to Netdata.
- Deletes the Netdata user and group.
- Cleans up the systemd service configuration.
- Checks and terminates any remaining Netdata processes.

## Prerequisites

1. The script requires **sudo** privileges to execute the necessary commands.
2. Ensure that the server has `systemctl` and `apt-get` installed and configured.
3. Run the script on non-WO servers only.

## Usage

### Steps to Run the Script

1. Save the script to a file, for example, `remove_netdata.sh`.
2. Make the script executable:
   ```bash
   chmod +x remove_netdata.sh
   ```
3. Run the script:
   ```bash
   sudo ./remove_netdata.sh
   ```

### What the Script Does

1. Stops the Netdata service:
   ```bash
   sudo systemctl stop netdata
   ```
2. Disables the Netdata service:
   ```bash
   sudo systemctl disable netdata
   ```
3. Uninstalls Netdata using `apt-get`:
   ```bash
   sudo apt-get remove --purge -y netdata
   sudo apt-get autoremove --purge -y netdata
   ```
4. Removes all related directories and files:
   ```bash
   sudo rm -rf /etc/netdata /var/lib/netdata /usr/lib/netdata /var/cache/netdata /var/log/netdata /usr/share/netdata
   ```
5. Deletes the Netdata user and group:
   ```bash
   sudo deluser --remove-home netdata
   sudo delgroup netdata
   ```
6. Cleans up the systemd service:
   ```bash
   sudo systemctl daemon-reload
   sudo systemctl reset-failed
   ```
7. Checks and terminates any remaining Netdata processes:
   ```bash
   remaining_processes=$(ps aux | grep netdata | grep -v grep)
   sudo killall netdata
   ```

## Output

- The script prints status messages for each step to keep the user informed of the process.

## Notes

- The script is tailored for systems using **apt-get** (Debian-based distributions). For other distributions, the package manager commands may need to be updated.
- Always test the script on a staging server before using it on production systems.
- Ensure that Netdata is not actively being used or monitored on the server before running the script.

## Disclaimer

This script is provided "as-is" without any warranties. Use it at your own risk. The author is not responsible for any damages or data loss resulting from its use.

---

For any issues or questions, feel free to reach out.




