#!/bin/bash
# -----------------------------------------------------------------------------
# Stop Server Script - Gracefully stops the Node.js application
# -----------------------------------------------------------------------------

echo "Stopping application server..."

# Stop PM2 processes
if command -v pm2 &> /dev/null; then
    sudo -u ec2-user pm2 stop all 2>/dev/null || true
    sudo -u ec2-user pm2 delete all 2>/dev/null || true
fi

echo "Application stopped"
