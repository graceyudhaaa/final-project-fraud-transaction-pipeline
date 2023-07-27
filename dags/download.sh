#!/usr/bin/env bash

echo "Downloading Data"
fileid="1eEp7uXN8EUnYhrqf5r6fP9Dij9-uBs6P"
filename="online_transaction"
curl -fc ./cookie -s -L "https://drive.google.com/uc?export=download&id=${fileid}" > /dev/null
curl -fLb ./cookie "https://drive.google.com/uc?export=download&confirm=`awk '/download/ {print $NF}' ./cookie`&id=${fileid}" -o "/opt/airflow/datasets/${filename}.zip"
unzip /opt/airflow/datasets/${filename}.zip -d /opt/airflow/datasets/ 
# rm "/opt/airflow/datasets/${filename}.zip"
$(rm cookie)
zipinfo -1 /opt/airflow/datasets/${filename}.zip