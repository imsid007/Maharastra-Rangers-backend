#!/bin/bash
# -----------------------------------------------------------------------------
# Start Server Script - Starts the Node.js application using PM2
# -----------------------------------------------------------------------------

set -e

echo "Starting application server..."

cd /opt/app

# Start the application with PM2
sudo -u ec2-user pm2 start src/server.js \
    --name "mh-backend" \
    --time \
    --log /opt/app/logs/app.log \
    --error /opt/app/logs/error.log \
    --merge-logs

# Save PM2 process list
sudo -u ec2-user pm2 save

# Wait for application to start
sleep 5

echo "Application started successfully"
