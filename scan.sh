#!/bin/bash

FAILED=0

echo "Testing bluetooth on RPI3. Make sure you have a bluetooth device enabled and visible."

echo "Scan for devices..."
if [ `hcitool scan | wc -l` -le 1 ]; then
    FAILED=1
else
    FAILED=0
fi

echo "Test finished. App configured to not exit. Restart the app if you want to retest."

# Test result
if [ $FAILED -eq 1 ]; then
    echo "TEST FAILED"
else
    echo "TEST PASSED"
fi

# Don't exit the process
while true; do
    sleep 1
done
