# ImageNet ILSVRC2012 Extraction Script

This script extracts the ILSVRC2012 ImageNet training and validation sets, with **resume capability** (skips already extracted categories).  
It automatically organizes images into class folders compatible with standard ImageNet training pipelines.

---
## Usage Instructions

### 1️⃣ Upload the script to your server or Kubernetes Pod

Place the script `extract_ILSVRC_clean.sh` into the directory containing:
- `ILSVRC2012_img_train.tar`
- `ILSVRC2012_img_val.tar`

For example:
/mnt/viktor/ImageNet/

### 2️⃣ Convert line endings (important for Windows users)
If you edited or downloaded the script on Windows, convert it to Unix line endings before running:

apt-get update
apt-get install -y dos2unix
dos2unix extract_ILSVRC_clean.sh
Why: Windows uses CRLF line endings which will cause errors ($\r command not found) in Linux shells.

### 3️⃣ Make the script executable

chmod +x extract_ILSVRC_clean.sh
### 4️⃣ Run the script (supports resume and safe restarts)
To prevent interruptions if you disconnect, run it in the background:

nohup bash extract_ILSVRC_clean.sh > extract.log 2>&1 &
Monitor progress:

tail -f extract.log
### 5️⃣ Check if extraction is complete
You should see this at the end of extract.log:

整理 val 图片到各类别目录（官方脚本）...
解压完成！
Or verify manually:

ls -d train/*/ | wc -l  # Should output 1000
ls -d val/*/ | wc -l    # Should output 1000

Script Features
✅ Automatic resume for interrupted extractions
✅ Skips already extracted categories (safe to rerun)
✅ Automatic class folder organization for both train and val
✅ Background execution supported (nohup recommended)

Known Limitations
The script does not delete the original tar files after extraction to allow resuming.

For disk space saving, consider manually deleting tar files after successful extraction.

rm ILSVRC2012_img_train.tar
rm ILSVRC2012_img_val.tar
