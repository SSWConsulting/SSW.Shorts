#!/bin/bash
RESOURCE_GROUP_NAME="SSW.Shorts"
TEMPLATE_FILE="arm/template.json"
DEPLOYMENT_NAME=$(date +"%Y-%m-%d_%H-%M-%S")
echo $DEPLOYMENT_NAME

echo 'Input your SubscriptionId'
read SUBSCRIPTION_ID

az login --output none

az group deployment create \
	--verbose \
	--name "$DEPLOYMENT_NAME" \
	--resource-group $RESOURCE_GROUP_NAME \
	--template-file $TEMPLATE_FILE \
	--subscription $SUBSCRIPTION_ID