FROM apache/airflow:2.6.3

# ENV AIRFLOW_HOME=/opt/airflow

# WORKDIR $AIRFLOW_HOME

# USER root

USER root
RUN apt update -y
RUN apt upgrade -y
# RUN apt install default-jdk -y
RUN apt install zip unzip -y
# RUN apt install git -y

RUN apt-get install -y --no-install-recommends \
         openjdk-11-jre-headless \
  && apt-get autoremove -yqq --purge \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*
USER airflow
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64

USER airflow
RUN pip install pyarrow pyspark dbt-core dbt-bigquery pandas numpy apache-airflow-providers-apache-spark airflow-dbt-python[bigquery] apache-airflow[google]