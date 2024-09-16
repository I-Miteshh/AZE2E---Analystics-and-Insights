#!/bin/bash

# Define Variables
RESOURCE_GROUP="AZE2E-ResourceGroup"
LOCATION="eastus"
EVENT_HUB_NAMESPACE="aze2e-namespace"
EVENT_HUB_NAME="uber-pickups"
STORAGE_ACCOUNT="aze2estorage"
CONSUMER_GROUP="aze2e-consumer-group"
DATA_FACTORY="AZE2E-DataFactory"
DATABRICKS_WORKSPACE="AZE2E-Databricks"
EVENT_GRID_FUNCTION_APP="AZE2E-EventGridTrigger"

# Create Resource Group
echo "Creating Resource Group: $RESOURCE_GROUP"
az group create --name $RESOURCE_GROUP --location $LOCATION

# Create Storage Account for Event Hubs Capture
echo "Creating Storage Account: $STORAGE_ACCOUNT"
az storage account create --name $STORAGE_ACCOUNT --resource-group $RESOURCE_GROUP --location $LOCATION --sku Standard_LRS

# Create Event Hub Namespace
echo "Creating Event Hub Namespace: $EVENT_HUB_NAMESPACE"
az eventhubs namespace create --name $EVENT_HUB_NAMESPACE --resource-group $RESOURCE_GROUP --location $LOCATION

# Create Event Hub
echo "Creating Event Hub: $EVENT_HUB_NAME"
az eventhubs eventhub create --name $EVENT_HUB_NAME --namespace-name $EVENT_HUB_NAMESPACE --resource-group $RESOURCE_GROUP

# Create Event Hub Consumer Group
echo "Creating Consumer Group: $CONSUMER_GROUP"
az eventhubs eventhub consumer-group create --resource-group $RESOURCE_GROUP --namespace-name $EVENT_HUB_NAMESPACE --eventhub-name $EVENT_HUB_NAME --name $CONSUMER_GROUP

# Create Azure Data Factory
echo "Creating Azure Data Factory: $DATA_FACTORY"
az datafactory create --resource-group $RESOURCE_GROUP --factory-name $DATA_FACTORY --location $LOCATION

# Create Azure Databricks Workspace
echo "Creating Azure Databricks Workspace: $DATABRICKS_WORKSPACE"
az databricks workspace create --resource-group $RESOURCE_GROUP --name $DATABRICKS_WORKSPACE --location $LOCATION --sku standard

# Create Azure Function App to Trigger ADF (Optional Step for Event Grid)
echo "Creating Azure Function App for Event Grid Trigger: $EVENT_GRID_FUNCTION_APP"
az functionapp create --resource-group $RESOURCE_GROUP --consumption-plan-location $LOCATION --name $EVENT_GRID_FUNCTION_APP --storage-account $STORAGE_ACCOUNT --runtime dotnet

# Output Summary
echo "----------------------------------------------------------"
echo "All resources created successfully!"
echo "Resource Group: $RESOURCE_GROUP"
echo "Event Hub Namespace: $EVENT_HUB_NAMESPACE"
echo "Event Hub: $EVENT_HUB_NAME"
echo "Consumer Group: $CONSUMER_GROUP"
echo "Azure Data Factory: $DATA_FACTORY"
echo "Databricks Workspace: $DATABRICKS_WORKSPACE"
echo "Function App for Event Grid Trigger: $EVENT_GRID_FUNCTION_APP"
echo "----------------------------------------------------------"

# Additional Notes
echo "Next steps:"
echo "1. Configure Azure Databricks with the notebook from the 'notebooks/' folder."
echo "2. Import the ADF pipeline template from 'adf_pipeline/adf_pipeline.json'."
echo "3. Set up the Azure Function to trigger ADF when an Event Grid event is raised."
