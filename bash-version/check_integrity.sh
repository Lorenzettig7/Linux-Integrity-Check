BINARIES=("gprof" "setpci" "xzless" "setarch")
BIN_DIR="/usr/bin"
LOG_FILE="integrity_check.log"
> "$LOG_FILE"

echo "Starting Integrity Check..." | tee -a "$LOG_FILE"
echo "----------------------------------------" | tee -a "$LOG_FILE"

for BIN in "${BINARIES[@]}"; do
    BIN_PATH="$BIN_DIR/$BIN"
    if [ ! -f "$BIN_PATH" ]; then
        echo "❗ Binary $BIN not found in $BIN_DIR" | tee -a "$LOG_FILE"
        continue
    fi

    echo "Checking $BIN..." | tee -a "$LOG_FILE"

    PACKAGE=$(dpkg -S "$BIN_PATH" 2>/dev/null | cut -d':' -f1)
    
    if [ -z "$PACKAGE" ]; then
        echo "❗ Could not find package for $BIN" | tee -a "$LOG_FILE"
        continue
    fi

    MD5_BEFORE=$(md5sum "$BIN_PATH" | awk '{ print $1 }')

    sudo apt-get install --reinstall -y "$PACKAGE" > /dev/null

    MD5_AFTER=$(md5sum "$BIN_PATH" | awk '{ print $1 }')

    if [ "$MD5_BEFORE" == "$MD5_AFTER" ]; then
        echo "✅ $BIN has NOT been altered." | tee -a "$LOG_FILE"
    else
        echo "🚨 $BIN has BEEN ALTERED!" | tee -a "$LOG_FILE"
    fi

    echo "----------------------------------------" | tee -a "$LOG_FILE"
done

echo "Integrity Check Complete." | tee -a "$LOG_FILE"

