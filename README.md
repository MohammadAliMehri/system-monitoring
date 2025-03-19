# System Monitoring and Maintenance Script

This Bash script performs the following system maintenance tasks:

- Updates and upgrades the system packages
- Cleans APT cache and removes unnecessary packages
- Monitors system performance using `vmstat`, `iostat`, and `mpstat`
- Saves system monitoring logs to files
- Checks and installs required packages (`sysstat` and `curl`)
- Sends a report and monitoring logs to a Telegram bot

## Prerequisites

Before using this script, ensure you have:

- A Telegram bot token
- Your Telegram chat ID
- A Linux system with `apt` package manager

## Usage

1. Clone the repository:
   ```bash
   git clone https://github.com/MohammadAliMehri/system-monitoring-script.git
   cd system-monitoring-script
   ```
2. Open the script and replace `TOKEN="token_bot"` and `CHAT_ID="chat_id"` with your actual Telegram bot token and chat ID.
3. Give execution permission to the script:
   ```bash
   chmod +x system_monitor.sh
   ```
4. Run the script manually:
   ```bash
   ./system_monitor.sh
   ```

## Automating with Cron Job

To execute this script every 24 hours automatically, add it to the cron jobs:

1. Open the crontab editor:
   ```bash
   crontab -e
   ```
2. Add the following line at the end:
   ```bash
   0 0 * * * /path/to/system_monitor.sh
   ```
   This will execute the script every day at midnight (00:00 AM).
3. Save and exit the editor.

You can check if the cron job is scheduled correctly with:
```bash
crontab -l
```


Feel free to contribute or suggest improvements! 🚀

