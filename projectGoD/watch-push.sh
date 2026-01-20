#!/data/data/com.termux/files/usr/bin/bash

# ใช้ path ที่รันสคริปต์
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$SCRIPT_DIR"

echo "👁️  กำลังเฝ้าดูไฟล์แบบเรียลไทม์..."
echo "📁 โฟลเดอร์: $SCRIPT_DIR"
echo "-----------------------------------"

inotifywait -m -r -e modify,create,delete,move . |
while read path action file; do
    # ข้าม .git folder
    if [[ "$path" == *".git"* ]]; then
        continue
    fi
    
    echo "📝 ตรวจพบ: $action - $file"
    
    sleep 2
    
    git add .
    
    TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
    git commit -m "Auto update: $file - $TIMESTAMP" 2>/dev/null
    
    if [ $? -eq 0 ]; then
        echo "⬆️  กำลัง Push..."
        git push
        echo "✅ Push สำเร็จ!"
    else
        echo "ℹ️  ไม่มีการเปลี่ยนแปลง"
    fi
    
    echo "-----------------------------------"
done
