# dbt + Google BigQuery demo

In this repo I am going to show how to use dbt with Google BigQuery.
It will be my first experience with dbt and BigQuery, so I will be learning as I go.
Let's go!

<div style="display: flex; margin-right: 200px;">
  <img src="https://images.g2crowd.com/uploads/product/image/social_landscape/social_landscape_017ca5b65bc8cc79fa434f2716af16ee/dbt.png" alt="Image 1" width="300" height="200">
  <img src="https://seeklogo.com/images/G/google-big-query-logo-AC63E7C329-seeklogo.com.png" alt="Image 2" width="500" height="200">
</div>

___


## Prerequisites

- [ ] [dbt](https://docs.getdbt.com/dbt-cli/installation)
- [ ] [Google Cloud account](https://cloud.google.com/)
- [ ] [Google Cloud project](https://cloud.google.com/resource-manager/docs/creating-managing-projects)
- [ ] [Terraform](https://www.terraform.io/downloads.html)

## About Dataset

### Context

Linst to dataset [here](https://www.kaggle.com/datasets/ealtman2019/credit-card-transactions?select=credit_card_transactions-ibm_v2.csv).

Limited credit card transaction data is available for training fraud detection models and other uses, such as analyzing similar purchase patterns. Credit card data that is available often has significant obfuscation, relatively few transactions, and short time duration. For example, [this Kaggle dataset](https://www.kaggle.com/mlg-ulb/creditcardfraud) has 284,000 transactions over two days, of which less than 500 are fraudulent. In addition, all but two columns have had a principal components transformation, which obfuscates true values and makes the column values uncorrelated.

### Content
The data here has almost no obfuscation and is provided in a CSV file whose schema is described in the first row. This data has more than 20 million transactions generated from a multi-agent virtual world simulation performed by IBM. The data covers 2000 (synthetic) consumers resident in the United States, but who travel the world. The data also covers decades of purchases, and includes multiple cards from many of the consumers.

Further details about the generation are [here](https://arxiv.org/abs/1910.03033). Analyses of the data suggest that it is a reasonable match for real data in many dimensions, e.g. fraud rates, purchase amounts, Merchant Category Codes (MCCs), and other metrics. In addition, all columns except merchant name have their "natural" value. Such natural values can be helpful in feature engineering of models.

### File descriptions:

- `credit_card_transactions-ibm_v2.csv` (2.35 GB) - the main file with 20 million transactions
- `sd254_cards.csv` (487.12 kB) - information about cards
- `sd254_users.csv` (224.39 kB) - inforamtion about users

## Setup

### Google Cloud

1. Create a new project in Google Cloud.
2. Create a new service account with the following roles:
    - BigQuery Admin
    - Storage Admin
    - Storage Object Admin
    - Storage Object Creator
    - Storage Object Viewer
3. Create a new key for the service account and download it as a JSON file.

### Terraform

In this section it should specified the creating of the bucket and datasets. See `main.tf` in this repo for example.

### dbt

1. This is a [link to the course](https://courses.getdbt.com/courses/fundamentals) with detailed instructions. 
2. Create a new project in dbt Cloud.
3. Create a new connection to BigQuery.
4. Create a new connection to GitHub.
5. Follow the instructions. In his repo I will use syntethetic transactions data as it is more interesting for me.

## Model description

Imagine that you work in the bank and guys from AI department and AML department asked you to create marts  with appropiate datasets. They want to use this data for training models or for fraud detection. 

**Models** are the core of dbt projects. They are the building blocks of your data transformation pipeline. Models are defined in `.sql` files in the `models` directory. Each model file contains a single SQL query that defines a dataset in your warehouse. Models can reference other models, and dbt will execute the necessary queries in the correct order to build your data pipeline.:

- `landing` - raw data from the source (Cloud bucket)
- `staging` - data from the landing layer with some light transformations (dbt)
- `intermediate` - data from the staging layer with more complex transformations (dbt)
- `mart` - data from the intermediate layer with aggregations (dbt) ready for use by Data Scientists

## Tests

Tests are a core feature of dbt. They allow you to test your data to ensure that it meets expectations. Tests are defined in `.sql` files in the `tests` directory (singular ones). Each test file contains a single SQL query that defines a test. Tests can reference models, and dbt will execute the necessary queries in the correct order to test your data pipeline.

There are two singular test in the repo, but both of them are fake cause the synthetic data is not ... perfect :).

1. First test is about checking if the total amount of transaction is not higher the credit limit. I know that it is not the best cause we don't have incomes, but it is just an example.
2. Second test is about checking if number of cards per users in `transactions` table is the same as in `cards` table.

## To be continued...