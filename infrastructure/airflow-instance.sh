#!/bin/bash

# Update all packages
sudo apt-get update
sudo apt-get upgrade -y

# Install Python and Pip and Git
sudo apt-get install -y python3
sudo apt install python3-pip
sudo apt install -y git

#install airflow
AIRFLOW_VERSION=2.6.3
PYTHON_VERSION="$(python3 --version | cut -d " " -f 2 | cut -d "." -f 1-2)"
CONSTRAINT_URL="https://raw.githubusercontent.com/apache/airflow/constraints-${AIRFLOW_VERSION}/constraints-${PYTHON_VERSION}.txt"
pip install "apache-airflow==${AIRFLOW_VERSION}" --constraint "${CONSTRAINT_URL}"

# add aitflow to PATH
PATH=$PATH:~/.local/bin

# install dbt cloud airflow plugin
pip install apache-airflow-providers-dbt-cloud[http]
