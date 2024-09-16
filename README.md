# AZE2E - Analytics and Insights

**AZE2E** is an end-to-end data pipeline project built using Azure services, Kafka, Databricks, and Apache Spark. It demonstrates real-time data ingestion, processing, and transformation using modern data engineering tools.

## Project Overview

This project simulates a real-time data analytics workflow for **Uber pickups** in New York City. The dataset is ingested through **Azure Event Hubs**, processed via **Apache Spark** in **Azure Databricks**, and orchestrated using **Azure Data Factory (ADF)**.

### Key Components:
- **Azure Event Hubs**: Handles real-time data ingestion.
- **Apache Kafka**: Facilitates the streaming of data into Databricks.
- **Azure Databricks**: Processes and transforms data using Spark.
- **Azure Data Factory**: Orchestrates the data pipeline for automation.
- **Azure Function (optional)**: Triggers the ADF pipeline via **Event Grid** based on data arrival.

## Dataset Used

- **Dataset**: Uber Pickups in New York City
- **Source**: [Uber Pickups in NYC - Kaggle](https://www.kaggle.com/datasets/fivethirtyeight/uber-pickups-in-new-york-city)
- **Fields**:
  - **Date/Time**: Uber pickup timestamp.
  - **Lat**: Latitude of the pickup.
  - **Lon**: Longitude of the pickup.
  - **Base**: Base company code.

This dataset is streamed in real-time via **Event Hubs** and processed in **Databricks** using Kafka and Spark for further analytics and visualization.

## Project Flow

1. **Data Ingestion (Event Hubs)**:
   - Real-time Uber pickup data is simulated and sent to **Azure Event Hubs**.

2. **Data Processing (Kafka & Databricks)**:
   - Data is streamed from **Event Hubs** into **Databricks** using **Apache Kafka**.
   - Databricks (Spark) processes and transforms the data (e.g., aggregating pickups by time or location).

3. **Orchestration (ADF Pipeline)**:
   - The entire workflow is automated and orchestrated using **Azure Data Factory**.
   - ADF pipelines are triggered based on data events (via **Azure Event Grid** and **Azure Function**) or on a scheduled basis.

4. **Visualization**:
   - The processed data can be visualized using tools like **Power BI** for deriving insights on Uber rides.

## Setup Instructions

### Prerequisites
- **Azure Subscription** with access to Event Hubs, Data Factory, and Databricks.
- **Azure CLI** installed on your machine.

### Step 1: Clone the Repository
- git clone https://github.com/your-repo/AZE2E-Analytics-Insights.git
- cd AZE2E-Analytics-Insights

### Step 2: Run Setup Script
- cd scripts
- chmod +x install.sh
- ./install.sh

### Step 3: Upload Dataset to Event Hubs
Simulate real-time data ingestion by streaming the dataset into Event Hubs. You can modify the data_stream.py script to handle the ingestion of Uber pickup data.

### Step 4: Configure Databricks and ADF
- Databricks: Upload the notebooks/transformation.scala file to your Databricks workspace.
- ADF: Import the ADF pipeline template from the adf_pipeline/ folder


### Step 5: Trigger the Pipeline
- Either schedule the pipeline or trigger it via Event Hubs events using Event Grid and Azure Functions.

### Summary
This project demonstrates the use of a real-time analytics pipeline with Azure Event Hubs, Databricks, and Azure Data Factory, handling Uber pickup data streaming and processing in near real-time.
