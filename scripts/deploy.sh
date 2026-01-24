#!/bin/bash
# -----------------------------------------------------------------------------
# Manual Deployment Script - Deploy via SSM
# Usage: ./scripts/deploy.sh <instance-id> <secrets-arn>
# -----------------------------------------------------------------------------

set -e

INSTANCE_ID=$1
SECRETS_ARN=$2
AWS_REGION=${3:-ap-south-1}

if [ -z "$INSTANCE_ID" ] || [ -z "$SECRETS_ARN" ]; then
    echo "Usage: ./scripts/deploy.sh <instance-id> <secrets-arn> [aws-region]"
    echo "Example: ./scripts/deploy.sh i-0123456789abcdef0 arn:aws:secretsmanager:ap-south-1:123456789:secret:my-secret"
    exit 1
fi

echo "Deploying to instance: $INSTANCE_ID"
echo "Using secrets from: $SECRETS_ARN"
echo "Region: $AWS_REGION"

# Create deployment package
echo "Creating deployment package..."
rm -rf deploy.zip deploy/
mkdir -p deploy
cp -r src deploy/
cp package.json deploy/
cp package-lock.json deploy/
cd deploy && zip -r ../deploy.zip . && cd ..

# Upload to S3 (temporary)
BUCKET_NAME="maharastra-rangers-temp-deploy-$(date +%s)"
aws s3 mb s3://$BUCKET_NAME --region $AWS_REGION
aws s3 cp deploy.zip s3://$BUCKET_NAME/deploy.zip

# Deploy via SSM
echo "Deploying via SSM..."
COMMAND_ID=$(aws ssm send-command \
    --instance-ids "$INSTANCE_ID" \
    --document-name "AWS-RunShellScript" \
    --region "$AWS_REGION" \
    --parameters commands="[
        'cd /opt/app',
        'aws s3 cp s3://$BUCKET_NAME/deploy.zip /tmp/deploy.zip',
        'rm -rf /opt/app/*',
        'unzip /tmp/deploy.zip -d /opt/app',
        'chown -R ec2-user:ec2-user /opt/app',
        'cd /opt/app && sudo -u ec2-user npm ci --production',
        'SECRET_JSON=\$(aws secretsmanager get-secret-value --secret-id $SECRETS_ARN --query SecretString --output text --region $AWS_REGION)',
        'echo \"\$SECRET_JSON\" | python3 -c \"import json, sys; secrets = json.load(sys.stdin); [print(f\\\"{k}={v}\\\") for k,v in secrets.items()]\" > /opt/app/.env',
        'chmod 600 /opt/app/.env',
        'chown ec2-user:ec2-user /opt/app/.env',
        'sudo -u ec2-user pm2 delete all || true',
        'cd /opt/app && sudo -u ec2-user pm2 start src/server.js --name mh-backend',
        'sudo -u ec2-user pm2 save'
    ]" \
    --output text \
    --query 'Command.CommandId')

echo "SSM Command ID: $COMMAND_ID"
echo "Waiting for deployment to complete..."

# Wait for command completion
aws ssm wait command-executed \
    --command-id "$COMMAND_ID" \
    --instance-id "$INSTANCE_ID" \
    --region "$AWS_REGION" || true

# Get command status
STATUS=$(aws ssm get-command-invocation \
    --command-id "$COMMAND_ID" \
    --instance-id "$INSTANCE_ID" \
    --region "$AWS_REGION" \
    --query 'Status' \
    --output text)

echo "Deployment status: $STATUS"

# Cleanup
echo "Cleaning up..."
aws s3 rm s3://$BUCKET_NAME/deploy.zip
aws s3 rb s3://$BUCKET_NAME
rm -rf deploy.zip deploy/

if [ "$STATUS" = "Success" ]; then
    echo "Deployment completed successfully!"
    exit 0
else
    echo "Deployment failed. Check SSM command output for details."
    aws ssm get-command-invocation \
        --command-id "$COMMAND_ID" \
        --instance-id "$INSTANCE_ID" \
        --region "$AWS_REGION"
    exit 1
fi
