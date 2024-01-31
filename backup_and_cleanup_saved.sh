#!/bin/bash

# 设置源目录和备份目录
SOURCE_DIR="/home/steam/Steam/steamapps/common/PalServer/Pal/Saved"
BACKUP_DIR="/home/steam/Steam/steamapps/common/PalServer/Pal/Saved" # 替换为您的备份目录

# 为压缩文件设置带有时间戳的名称
ZIP_FILE="Saved-$(date +%Y%m%d-%H%M%S).zip"

# 压缩 Saved 文件夹
zip -r "$BACKUP_DIR/$ZIP_FILE" "$SOURCE_DIR"

# 删除三天前的备份
# 计算三天前的日期
THREE_DAYS_AGO=$(date -d "-3 days" +%Y%m%d)

# 在备份目录中查找并删除三天前的备份
find "$BACKUP_DIR" -name 'Saved-*.zip' -type f | while read FILE; do
    # 提取文件的日期
    FILE_DATE=$(echo $FILE | grep -oP 'Saved-\K(\d{8})')

    # 如果文件日期小于三天前的日期，则删除文件
    if [[ $FILE_DATE -lt $THREE_DAYS_AGO ]]; then
        rm -f "$FILE"
    fi
done

echo "备份和清理操作完成。"
