#!/bin/bash
LOG_DIR="logs"
mkdir -p $LOG_DIR

while true; do
  TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

  # shellcheck disable=SC2129
  echo "[$TIMESTAMP] CPU:" >> $LOG_DIR/system_metrics.log
  mpstat 1 1 | tail -n 2 >> $LOG_DIR/system_metrics.log

  echo "[$TIMESTAMP] MEMORY:" >> $LOG_DIR/system_metrics.log
  free -m >> $LOG_DIR/system_metrics.log

  echo "[$TIMESTAMP] DISK:" >> $LOG_DIR/system_metrics.log
  df -h >> $LOG_DIR/system_metrics.log

  echo "[$TIMESTAMP] GPU:" >> $LOG_DIR/system_metrics.log
  nvidia-smi --query-gpu=utilization.gpu,memory.used,memory.total --format=csv >> $LOG_DIR/system_metrics.log

  echo "----------------------------" >> $LOG_DIR/system_metrics.log
  sleep 10
done
