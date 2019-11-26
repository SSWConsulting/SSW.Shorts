#!/bin/bash

resourceGroup=${resourceGroup:-SSW.Shorts}
templateFile=${templateFile:-arm/template.json}
deploymentName=${deploymentName:-$(date +"%Y-%m-%d_%H-%M-%S")}
subscriptionId=${subscriptionId:-n/a}
location=${location:-Australia East}

# exit when any command fails
set -e

# read named params
while [ $# -gt 0 ];
do

   if [[ $1 == *"--"* ]]; then
        param="${1/--/}"
        declare $param="$2"
        # echo $1 $2 // Optional to see the parameter:value result
   fi

  shift
done

if [ $subscriptionId != "n/a" ]
then
	echo "Setting subscription"
	az account set --subscription $subscriptionId
fi

echo "Checking if RG $resourceGroup exists"
if [ $(az group exists --name $resourceGroup) == false ]; 
then
	echo "   Doesn't exist - are you logged into the correct subscription?"
	echo "   Tip: you can pass the subscription id with the parameter --subscriptionId"
	exit 1
fi

echo "Deploying $deploymentName to RG $resourceGroup"
az group deployment create \
	--verbose \
	--name "$deploymentName" \
	--resource-group $resourceGroup \
	--template-file $templateFile

echo "   Done"