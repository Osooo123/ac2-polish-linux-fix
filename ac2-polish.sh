#!/usr/bin/env bash

LOG="$HOME/ac2-wrapper.log"

echo "AC2 wrapper started at $(date)" >> "$LOG"

env -u LD_PRELOAD timeout 45s protontricks -c "wine reg add \"HKLM\\Software\\Wow6432Node\\UBISOFT\\Assassin's Creed II\" /v language /t REG_SZ /d Polish /f" 33230 >> "$LOG" 2>&1

env -u LD_PRELOAD timeout 45s protontricks -c "wine reg add \"HKLM\\Software\\Wow6432Node\\UBISOFT\\Assassin's Creed II\\GameUpdate\" /v language /t REG_SZ /d pl /f" 33230 >> "$LOG" 2>&1

echo "Launching command: $*" >> "$LOG"

exec "$@"
