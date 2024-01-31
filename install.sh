#!/bin/bash

# 定义下载路径和脚本位置
SCRIPT_URL="https://raw.githubusercontent.com/sekaikunkun/PalAutoSave/main/backup_and_cleanup_saved.sh"
SCRIPT_PATH="/usr/local/bin/backup_and_cleanup_saved.sh"

# 下载脚本
curl -o "$SCRIPT_PATH" "$SCRIPT_URL" || wget -O "$SCRIPT_PATH" "$SCRIPT_URL"

# 检查下载是否成功
if [ ! -f "$SCRIPT_PATH" ]; then
    echo "下载失败，请检查 URL 是否正确，或网络是否连接。"
    exit 1
fi

# 赋予执行权限
chmod +x "$SCRIPT_PATH"

# 创建 cron 任务
CRON_JOB="0 * * * * $SCRIPT_PATH"

# 检查当前用户的 crontab 中是否已经存在这个任务
if ! crontab -l | grep -Fq "$SCRIPT_PATH"; then
    # 将新的 cron 任务添加到 crontab
    (crontab -l 2>/dev/null; echo "$CRON_JOB") | crontab -
fi

echo "安装完成，备份脚本已配置为每小时运行一次。"
