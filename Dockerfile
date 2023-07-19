FROM apache/airflow:2.6.3

# ENV AIRFLOW_HOME=/opt/airflow

# WORKDIR $AIRFLOW_HOME

# USER root

# ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
USER root
RUN apt update -y
RUN apt upgrade -y
RUN apt install default-jdk -y
RUN apt install zip unzip -y
# RUN apt install git -y

USER airflow
RUN pip install pyarrow pyspark dbt-core dbt-bigquery pandas numpy apache-airflow-providers-apache-spark airflow-dbt-python[bigquery] apache-airflow[google]