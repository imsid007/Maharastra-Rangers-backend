#!/bin/bash
# -----------------------------------------------------------------------------
# Validate Service Script - Checks if the application is running correctly
# -----------------------------------------------------------------------------

set -e

echo "Validating application..."

# Wait for application to be ready
sleep 10

# Check if PM2 process is running
if ! sudo -u ec2-user pm2 list | grep -q "mh-backend"; then
    echo "ERROR: Application is not running in PM2"
    exit 1
fi

# Check if application is responding on health endpoint
HEALTH_URL="http://localhost:3000/health"
HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" $HEALTH_URL || echo "000")

if [ "$HTTP_STATUS" = "200" ]; then
    echo "Application is healthy (HTTP $HTTP_STATUS)"
    exit 0
else
    echo "ERROR: Health check failed (HTTP $HTTP_STATUS)"
    # Show PM2 logs for debugging
    sudo -u ec2-user pm2 logs --lines 50 --nostream
    exit 1
fi
