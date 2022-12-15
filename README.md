# Advertisement Click Through Prediction
Classification model to predict if an advertisement attached to an online transaction will be clicked

### Click Through Rate (CTR) and Machine Learning Powered Ad Selection Process
Of the total digital ad spending each year, approximately 55% goes to display advertising. Click-through rate (CTR) is calculated by dividing the number of clicks by the number of views. It is one of the metrics in measuring the effectiveness of digital ad, since a click is often the first step toward a consumer making a purchase. 

CTR is affected by many factors, from contextual relevance like where an ad is running and position on a page, to user attributes including transaction time, which device a person is using and their location and a lot other factors. In this project, user attributes are used to build a classification model in predicting the probability of a click.

### Step 1 - Data Aggregation and Feature Engineering with SQL
Transactional data collected from an online payment system are stored in multiple csv files. Source data are first loaded into relational databases for data cleansing, label creation and feature engineering. The aggregted dataset is then loaded as Python dataframe for the modeling process.

### Step 2 - Classification Model
Binary classification model is built to predict the probability of an ad click when a transaction is made.
