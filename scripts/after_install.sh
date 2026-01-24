#!/bin/bash
# -----------------------------------------------------------------------------
# After Install Script - Runs after files are copied to the instance
# -----------------------------------------------------------------------------

set -e

echo "Running after_install script..."

cd /opt/app

# Set proper ownership
chown -R ec2-user:ec2-user /opt/app

# Install production dependencies (if node_modules not included in artifact)
if [ ! -d "node_modules" ]; then
    echo "Installing dependencies..."
    sudo -u ec2-user npm ci --production
fi

# Ensure .env file has correct permissions
if [ -f ".env" ]; then
    chmod 600 .env
    chown ec2-user:ec2-user .env
fi

echo "After install completed successfully"
