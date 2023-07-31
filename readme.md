# Final Project: Fraud Transaction Pipeline

## Data
You can download the dataset [here](https://drive.google.com/file/d/1LmPGE7Vgn1yYszM0s9nwfmwr36RHI3BB/view?usp=drive_link)

## Bussiness Understanding
### Problem Description
A Digital Wallet company has quite a large amount of online transaction data. The company wants to acknowledging data limitation and uncertainties such as inaccurate or missing crucial information data. On the other hand, the company also wants to use online transaction data to detect online payment fraud that harms their business.

### Goals
Create a data pipeline that can be utilised for analysis and reporting to determine whether online transaction data has excellent data quality and can be used to detect fraud in online transactions. 

### Project Objectives
- Create an **automated pipeline** that facilitates the batch and stream data processing from various data sources to data warehouses and data mart.
- Create a **visualization dashboard** to obtain meaningful insights from the data, enabling informed business decisions.

## Pipeline Architecture

Image 1. Pipeline Architecture
![architecture](images/architecture.png)


## Tools
- Orchestration: Airflow
- Tranformation: Spark, dbt 
- Streaming: Kafka
- Container: Docker
- Storage: Google Cloud Storage
- Warehouse: BigQuery
- Data Visualization: Looker

## Project Instruction
##### Clone this repository and enter the directory
```
git clone https://github.com/graceyudhaaa/final-project-fraud-transaction-pipeline.git && cd final-project-fraud-transaction-pipeline
```
Create a folder named `service-account` Create a GCP project. Then, create a service account with Editor role. Download the JSON credential rename it to `service-account.json` and store it on the `service-account` folder.

##### Cloud Resource Provisioning with Terraform
1. Install [Terraform CLI](https://developer.hashicorp.com/terraform/downloads?product_intent=terraform)
1. Change directory to terraform by executing
    ```
    cd terraform
    ```
1. Initialize Terraform (set up environment and install Google provider)
    ```
    terraform init
    ```
1. Create new infrastructure by applying Terraform plan
    ```
    terraform apply
    ```
1. Check your GCP project for newly created resources (GCS Bucket and BigQuery Datasets)

##### Manually Create Resources
Alternatively you can create the resources manually:
1. Create a GCS bucket named `final-project-lake`, set the region to `asia-southeast2`
1. Create two datasets in BigQuery named `onlinetransaction_wh` and `onlinetransaction_stream`

## Batch Processing

## Streaming Processing

##### Enter the directory streaming pipeline
```bash
cd kafka
```

##### Create streaming pipeline with Docker Compose
```bash
docker-compose up
```

##### Install required Python packages
```bash
pip install -r requirements.txt
```

##### Setup Email for Notification
1. Copy the `env.example` file, rename it to `.env`
1. Fill the required information for the sender and receiver email


##### Run the producer to stream the data into the Kafka topic
```bash
python producer.py
```

##### Run the consumer to consume the data from Kafka topic and load them into BigQuery
```bash
python consumer.py
```
<br>

Data will be loaded into the record table for all transactions in BigQuery, and if any data is detected as fraud, it will be recorded in the detected_fraud table, and an automatic email notification indicating fraud will be sent.


Image 2. Streaming Process <br>
![streaming-process](images/fraud-detection.gif)

Image 3. Fraud Detected Table <br>
![fraud-table](images/fraud-table.jpeg)

Image 4. Email Notification from Data that Detected Fraud
![notification](images/notification.jpeg)

##### DEBUGGING: Schema Registry Exited
If you run into a problem where, the schema registry image was exited. with the message
```
INFO io.confluent.admin.utils.ClusterStatus - Expected 1 brokers but found only 0. Trying to query Kafka for metadata again
```

You might want to reset your firewall with running this on your command line with administrator permission
```
iisreset
```


## Data Warehouse

## Analytic and Visualization
The outcome of this comprehensive data pipeline project is a dashboard that allows someone get insight for fraudulent transaction.

Our dashboard through the following link:
[Online Transaction Fraud Dashboard](quora.com/profile/Ashish-Kulkarni-100)

![architecture](images/dashboard-1.jpg)
![architecture](images/dashboard-2.jpg)