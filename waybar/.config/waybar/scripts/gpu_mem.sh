#!/usr/bin/env bash
IFS=', ' read -r USED TOTAL <<< $(nvidia-smi --query-gpu=memory.used,memory.total --format=csv,noheader,nounits)

PERCENT=$((USED * 100 / TOTAL))

echo "󰢮  GPU: ${PERCENT}% | "
