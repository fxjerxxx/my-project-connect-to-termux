#!/data/data/com.termux/files/usr/bin/bash

# ตั้งค่า
PROJECT_DIR="/storage/emulated/0/my-project"
SLEEP_TIME=30  # เช็คทุก 30 วินาที

cd "$PROJECT_DIR"

echo "🚀 Auto Git Push เริ่มทำงาน..."
echo "📁 โฟลเดอร์: $PROJECT_DIR"
echo "⏰ เช็คทุก $SLEEP_TIME วินาที"
echo "-----------------------------------"

while true; do
    # เช็คว่าไฟล์มีการเปลี่ยนแปลงไหม
    if [[ -n $(git status --porcelain) ]]; then
        echo "📝 พบการเปลี่ยนแปลง..."
        
        # Add ไฟล์ทั้งหมด
        git add .
        
        # Commit พร้อมเวลา
        TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
        git commit -m "Auto update: $TIMESTAMP"
        
        # Push ขึ้น GitHub
        echo "⬆️  กำลัง Push..."
        git push
        
        echo "✅ Push สำเร็จ! ($TIMESTAMP)"
        echo "-----------------------------------"
    fi
    
    sleep $SLEEP_TIME
done
