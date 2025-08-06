#!/bin/sh
pgrep -f "echo Hello from cron" > /dev/null || echo "Hello from cron" >> /output/cron.log