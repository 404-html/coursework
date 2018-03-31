#!/bin/bash 
ps aux | grep $EXC_LAB3_ROOT_DIR/src/server.py | awk '{print $2}' | xargs kill -9 > /dev/null 2>&1
ps aux | grep $EXC_LAB3_ROOT_DIR/bin/run_db | awk '{print $2}' | xargs kill -9 > /dev/null 2>&1
