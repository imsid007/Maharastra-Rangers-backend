#!/bin/bash
# -----------------------------------------------------------------------------
# Before Install Script - Runs before the new version is installed
# -----------------------------------------------------------------------------

set -e

echo "Running before_install script..."

# Stop the application if running
if command -v pm2 &> /dev/null; then
    pm2 stop all 2>/dev/null || true
fi

# Clean up old deployment
if [ -d "/opt/app" ]; then
    echo "Cleaning up old deployment..."
    rm -rf /opt/app/*
fi

# Ensure app directory exists with proper permissions
mkdir -p /opt/app
chown -R ec2-user:ec2-user /opt/app

echo "Before install completed successfully"
