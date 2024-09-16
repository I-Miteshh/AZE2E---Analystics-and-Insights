#!/bin/bash
# Set variables
RESOURCE_GROUP="AZE2E-ResourceGroup"
EVENT_HUB_NAMESPACE="aze2e-namespace"
EVENT_HUB_NAME="uber-pickups"
STORAGE_ACCOUNT="aze2eblobstorage"
CONSUMER_GROUP="aze2e-consumer-group"

# Create a resource group
az group create --name $RESOURCE_GROUP --location eastus

# Create a storage account for Event Hubs capture
az storage account create --name $STORAGE_ACCOUNT --resource-group $RESOURCE_GROUP --location eastus --sku Standard_LRS

# Create an Event Hubs namespace
az eventhubs namespace create --name $EVENT_HUB_NAMESPACE --resource-group $RESOURCE_GROUP --location eastus

# Create an Event Hub
az eventhubs eventhub create --name $EVENT_HUB_NAME --namespace-name $EVENT_HUB_NAMESPACE --resource-group $RESOURCE_GROUP

# Create a consumer group
az eventhubs eventhub consumer-group create --resource-group $RESOURCE_GROUP --namespace-name $EVENT_HUB_NAMESPACE --eventhub-name $EVENT_HUB_NAME --name $CONSUMER_GROUP

echo "Azure Event Hubs setup complete."
