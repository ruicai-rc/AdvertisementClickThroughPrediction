SET GLOBAL local_infile = TRUE;

-- Create database
DROP DATABASE IF EXISTS ctr;
CREATE DATABASE ctr;

-- Select default database;
USE ctr;

-- ------------------------------------- transactions ----------------------------------------
-- Create transactions table
DROP TABLE IF EXISTS ctr.transactions;

CREATE TABLE ctr.transactions (
    user_id         VARCHAR(20),
    txn_timestamp   DATETIME,
    money           VARCHAR(20),
    kind_pay        VARCHAR(20),
    kind_card       VARCHAR(20),
    store_id        VARCHAR(20),
    network         VARCHAR(20),
    industry        VARCHAR(20),
    gender          VARCHAR(20),
    address         VARCHAR(255),
    PRIMARY KEY (user_id, txn_timestamp)
);

-- Load data into the transactions table
TRUNCATE ctr.transactions;

LOAD DATA LOCAL INFILE '/Users/ruicai/Desktop/DSBootcamp/Python/Assignments/ClickThroughRate/midterm_ctr_data/re/4.new.csv'
INTO TABLE ctr.transactions
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n';

LOAD DATA LOCAL INFILE '/Users/ruicai/Desktop/DSBootcamp/Python/Assignments/ClickThroughRate/midterm_ctr_data/re/5.new.csv'
INTO TABLE ctr.transactions
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n';

LOAD DATA LOCAL INFILE '/Users/ruicai/Desktop/DSBootcamp/Python/Assignments/ClickThroughRate/midterm_ctr_data/re/6.new.csv'
INTO TABLE ctr.transactions
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n';

-- set empty strings as NULL values
UPDATE ctr.transactions SET money = NULL WHERE money = '';
UPDATE ctr.transactions SET kind_pay = NULL WHERE kind_pay = '';
UPDATE ctr.transactions SET kind_card = NULL WHERE kind_card = '';
UPDATE ctr.transactions SET store_id = NULL WHERE store_id = '';
UPDATE ctr.transactions SET network = NULL WHERE network = '';
UPDATE ctr.transactions SET industry = NULL WHERE industry = '';
UPDATE ctr.transactions SET gender = NULL WHERE gender = '';
UPDATE ctr.transactions SET address = NULL WHERE address = '';

-- modify data types
ALTER TABLE ctr.transactions
MODIFY COLUMN money DECIMAL(15, 2);

-- ------------------------------------------- views -----------------------------------------
-- Create views table
# note: primary key is not set as txn_timestamp, user_id can not decide unique entry
DROP TABLE IF EXISTS ctr.views;

CREATE TABLE ctr.views (
    ad_view_timestamp   VARCHAR(20),
    txn_timestamp       VARCHAR(20),
    user_id             VARCHAR(20),
    store_id            VARCHAR(20),
    ad_id               VARCHAR(20)
);

-- Load data into the views table
TRUNCATE ctr.views;

LOAD DATA LOCAL INFILE '/Users/ruicai/Desktop/DSBootcamp/Python/Assignments/ClickThroughRate/midterm_ctr_data/aug-view-01-09.csv'
INTO TABLE ctr.views
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n';

LOAD DATA LOCAL INFILE '/Users/ruicai/Desktop/DSBootcamp/Python/Assignments/ClickThroughRate/midterm_ctr_data/aug-view-10.csv'
INTO TABLE ctr.views
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n';

LOAD DATA LOCAL INFILE '/Users/ruicai/Desktop/DSBootcamp/Python/Assignments/ClickThroughRate/midterm_ctr_data/aug-view-11-31.csv'
INTO TABLE ctr.views
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n';

-- set empty strings as NULL values
UPDATE ctr.views SET ad_view_timestamp = NULL WHERE ad_view_timestamp = '';
DELETE FROM  ctr.views
WHERE (txn_timestamp = '')
   OR (txn_timestamp NOT LIKE '____-__-__ __:__:__')
   OR (user_id = '');
UPDATE ctr.views SET store_id = NULL WHERE store_id = '';
UPDATE ctr.views SET ad_id = NULL WHERE ad_id = '';

-- modify data types
ALTER TABLE ctr.views
MODIFY COLUMN ad_view_timestamp DATETIME,
MODIFY COLUMN txn_timestamp DATETIME;

-- --------------------------------- clicks -------------------------------------------------
-- Create clicks table
# note: primary key is not set as txn_timestamp, user_id can not decide unique entry
DROP TABLE IF EXISTS ctr.clicks;

CREATE TABLE ctr.clicks (
    ad_click_timestamp  VARCHAR(20),
    txn_timestamp       VARCHAR(20),
    user_id             VARCHAR(20),
    store_id            VARCHAR(20),
    ad_id               VARCHAR(20)
);

-- Load data into the clicks table
TRUNCATE ctr.clicks;

LOAD DATA LOCAL INFILE '/Users/ruicai/Desktop/DSBootcamp/Python/Assignments/ClickThroughRate/midterm_ctr_data/aug-click-01-09.csv'
INTO TABLE ctr.clicks
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n';

LOAD DATA LOCAL INFILE '/Users/ruicai/Desktop/DSBootcamp/Python/Assignments/ClickThroughRate/midterm_ctr_data/aug-click-10.csv'
INTO TABLE ctr.clicks
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n';

LOAD DATA LOCAL INFILE '/Users/ruicai/Desktop/DSBootcamp/Python/Assignments/ClickThroughRate/midterm_ctr_data/aug-click-11-31.csv'
INTO TABLE ctr.clicks
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n';

-- set empty strings as NULL values
UPDATE ctr.clicks SET ad_click_timestamp = NULL WHERE ad_click_timestamp = '';
DELETE FROM  ctr.clicks
WHERE (txn_timestamp = '')
   OR (txn_timestamp NOT LIKE '____-__-__ __:__:__')
   OR (user_id = '');
UPDATE ctr.clicks SET store_id = NULL WHERE store_id = '';
UPDATE ctr.clicks SET ad_id = NULL WHERE ad_id = '';

-- modify data types
ALTER TABLE ctr.clicks
MODIFY COLUMN ad_click_timestamp DATETIME,
MODIFY COLUMN txn_timestamp DATETIME;

-- ------------------------------------ ad_info ---------------------------------------------
-- Create ad_info table
DROP TABLE IF EXISTS ctr.ad_info;

CREATE TABLE ctr.ad_info (
    row_id       BIGINT,
    ad_id        VARCHAR(20) PRIMARY KEY,
    ad_loc       VARCHAR(20),
    ad_label     VARCHAR(20),
    begin_time   VARCHAR(20),
    end_time     VARCHAR(20),
    pic_url      VARCHAR(255),
    ad_url       VARCHAR(255),
    ad_desc_url  VARCHAR(255),
    ad_copy      VARCHAR(255),
    min_money    VARCHAR(20),
    store_id     VARCHAR(20),
    order_num    VARCHAR(255),
    user_id      VARCHAR(20),
    city_id      VARCHAR(20),
    idu_category VARCHAR(20),
    click_hide   VARCHAR(20),
    price        VARCHAR(20),
    sys          VARCHAR(20),
    network      VARCHAR(20),
    user_gender  VARCHAR(20),
    payment_kind VARCHAR(20)
);

-- Load data into the ad_info table
TRUNCATE ctr.ad_info;

LOAD DATA LOCAL INFILE '/Users/ruicai/Desktop/DSBootcamp/Python/Assignments/ClickThroughRate/midterm_ctr_data/aug-ad-info-with-tags.csv'
INTO TABLE ctr.ad_info
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n';

-- set empty strings as NULL values
UPDATE ctr.ad_info SET ad_loc = NULL WHERE ad_loc = '';
UPDATE ctr.ad_info SET ad_label = NULL WHERE ad_label = '';
UPDATE ctr.ad_info SET begin_time = NULL WHERE begin_time = '';
UPDATE ctr.ad_info SET end_time = NULL WHERE end_time = '';
UPDATE ctr.ad_info SET pic_url = NULL WHERE pic_url = '';
UPDATE ctr.ad_info SET ad_url = NULL WHERE ad_url = '';
UPDATE ctr.ad_info SET ad_desc_url = NULL WHERE ad_desc_url = '';
UPDATE ctr.ad_info SET min_money = NULL WHERE min_money = '';
UPDATE ctr.ad_info SET store_id = NULL WHERE store_id = '';
UPDATE ctr.ad_info SET order_num = NULL WHERE order_num = '';
UPDATE ctr.ad_info SET user_id = NULL WHERE user_id = '';
UPDATE ctr.ad_info SET city_id = NULL WHERE city_id = '';
UPDATE ctr.ad_info SET idu_category = NULL WHERE idu_category = '';
UPDATE ctr.ad_info SET click_hide = NULL WHERE click_hide = '';
UPDATE ctr.ad_info SET price = NULL WHERE price = '';
UPDATE ctr.ad_info SET sys = NULL WHERE sys = '';
UPDATE ctr.ad_info SET network = NULL WHERE network = '';
UPDATE ctr.ad_info SET user_gender = NULL WHERE user_gender = '';
UPDATE ctr.ad_info SET payment_kind = NULL WHERE payment_kind = '';

-- modify data types
ALTER TABLE ctr.ad_info
MODIFY COLUMN begin_time DATETIME,
MODIFY COLUMN end_time DATETIME,
MODIFY COLUMN min_money DECIMAL(15, 2),
MODIFY COLUMN price DECIMAL(15, 2);

-- --------------------------- unique_views ----------------------------------------
DROP TABLE IF EXISTS ctr.unique_views;
CREATE TABLE unique_views
    SELECT *
    FROM views
    GROUP BY ad_view_timestamp,
             txn_timestamp,
             user_id,
             ad_id,
             store_id;

-- --------------------------- unique_clicks ----------------------------------------
DROP TABLE IF EXISTS ctr.unique_clicks;
CREATE TABLE unique_clicks
    SELECT *
    FROM clicks
    GROUP BY ad_click_timestamp,
             txn_timestamp,
             user_id,
             ad_id,
             store_id;
-- ---------------------------------------- SAMPLE BY DATE ------------------------------------------------------------
-- --------------------------- sample_transactions ----------------------------------------
-- create table sample_transactions
-- transactions data with transaction date 2017-08-01 only
DROP TABLE IF EXISTS ctr.sample_transactions;
CREATE TABLE ctr.sample_transactions
    SELECT * FROM transactions
             WHERE txn_timestamp LIKE '2017-08-01 %';

-- --------------------------- sample_date_joined ----------------------------------------
-- create table sample_date_joined
-- joined from table: sample_transactions, unique_views, and unique_clicks
-- ** will be aggregated and used to build model
# validations:
# 1. row count (1,278,134) matches with sample_transactions table when aggregate by txn_timestamp and user_id
# 2. 1,099,220 entries in unique_views table on 2017-08-01 vs 1,099,219 unique entries on views level in sample_joined
# 3. 118,570 entries in unique_clicks table on 2017-08-01 vs 118,547 unique entries on clicks level in sample_joined
#    as some ad_id couldn't match with those in views table
DROP TABLE IF EXISTS ctr.sample_date_joined;
CREATE TABLE ctr.sample_date_joined
    SELECT s.user_id,
           s.txn_timestamp,
           HOUR(s.txn_timestamp) txn_hour,
           s.money,
           s.kind_pay,
           s.kind_card,
           s.store_id,
           s.network,
           s.industry,
           s.gender,
           s.address,
           v.ad_id,
           v.ad_view_timestamp,
           c.ad_click_timestamp,
           IF(ad_click_timestamp IS NULL, 0, 1) clicked
    FROM sample_transactions s
        LEFT JOIN unique_views v
            ON s.txn_timestamp = v.txn_timestamp
                   AND s.user_id = v.user_id
        LEFT JOIN unique_clicks c
            ON s.txn_timestamp = c.txn_timestamp
                   AND s.user_id = c.user_id
                   AND v.ad_id = c.ad_id;

-- ---------------------- df_date_aggregated ---------------------------------------------------------
-- create df_date_aggregated
DROP TABLE IF EXISTS ctr.df_date_aggregated;
# create a table aggregated from df_date_joined
CREATE TABLE ctr.df_date_aggregated
    SELECT user_id,
           COUNT(DISTINCT txn_timestamp) num_of_txn_per_hour,
           txn_hour,
           AVG(money) avg_money,
           kind_pay,
           kind_card,
           store_id,
           network,
           industry,
           gender,
           address,
           ad_id,
           COUNT(DISTINCT ad_view_timestamp) num_of_views_per_hour,
           IF(COUNT(DISTINCT txn_timestamp) = 0,
               0,
               COUNT(DISTINCT ad_view_timestamp) / COUNT(DISTINCT txn_timestamp)) avg_view_per_txn,
           COUNT(DISTINCT ad_click_timestamp) num_of_clicks_per_hour,
           IF(COUNT(DISTINCT txn_timestamp) = 0,
               0,
               COUNT(DISTINCT ad_click_timestamp) / COUNT(DISTINCT txn_timestamp)) avg_click_per_txn,
           IF(COUNT(DISTINCT ad_click_timestamp) = 0,
               0,
               COUNT(DISTINCT ad_view_timestamp) / COUNT(DISTINCT ad_click_timestamp)) avg_view_per_click,
           clicked,
           txn_day_of_week,
           AVG(seconds_between_txn_view) avg_seconds_between_txn_view,
           AVG(seconds_between_view_click) avg_seconds_between_view_click,
           AVG(seconds_between_txn_click) avg_seconds_between_txn_click
    FROM df_date_joined
    GROUP BY user_id,
             txn_hour,
             kind_pay,
             kind_card,
             store_id,
             network,
             industry,
             gender,
             address,
             ad_id,
             clicked,
             txn_day_of_week;

-- ------------------------------------- SAMPLE BY USER_ID ---------------------------------------------------------
-- --------------------------- sample_user_transactions ----------------------------------------
-- create sample table by user_id
DROP TABLE IF EXISTS ctr.sample_user_transactions;
# create a table with first 500,000 rows order by user_id
CREATE TABLE ctr.sample_user_transactions
    SELECT * FROM transactions
             ORDER BY user_id LIMIT 500000;
# insert last 500,000 rows order by user_id
INSERT INTO ctr.sample_user_transactions
    (SELECT * FROM transactions
              ORDER BY user_id DESC LIMIT 500000);
# insert mid 500,000 rows order by user_id
INSERT INTO ctr.sample_user_transactions
    (SELECT *
     FROM (SELECT * FROM transactions
                    ORDER BY user_id LIMIT 23000000) sliced_entries
     ORDER BY user_id DESC LIMIT 500000);

-- --------------------------- sample_user_joined ----------------------------------------
-- create table sample_user_joined
-- joined from table: sample_transactions, unique_views, and unique_clicks
-- ** will be aggregated and used to build model
DROP TABLE IF EXISTS ctr.sample_user_joined;
CREATE TABLE ctr.sample_user_joined
    SELECT s.user_id,
           s.txn_timestamp,
           HOUR(s.txn_timestamp) txn_hour,
           s.money,
           s.kind_pay,
           s.kind_card,
           s.store_id,
           s.network,
           s.industry,
           s.gender,
           s.address,
           v.ad_id,
           v.ad_view_timestamp,
           c.ad_click_timestamp,
           IF(ad_click_timestamp IS NULL, 0, 1) clicked
    FROM sample_user_transactions s
        LEFT JOIN unique_views v
            ON s.txn_timestamp = v.txn_timestamp
                   AND s.user_id = v.user_id
        LEFT JOIN unique_clicks c
            ON s.txn_timestamp = c.txn_timestamp
                   AND s.user_id = c.user_id
                   AND v.ad_id = c.ad_id;

-- --------------------------- df_user_with_ad ----------------------------------------
-- create table df_user_with_ad
DROP TABLE IF EXISTS df_user_with_ad;
CREATE TABLE df_user_with_ad
    SELECT d.*,
           row_id,
           ad_loc,
           ad_label,
           begin_time,
           end_time,
           pic_url,
           ad_url,
           ad_desc_url,
           ad_copy,
           min_money,
           a.store_id ad_store_id,
           order_num,
           a.user_id ad_user_id,
           city_id,
           idu_category,
           click_hide,
           price,
           sys,
           a.network user_network,
           user_gender,
           payment_kind
    FROM df_user_joined d
    LEFT JOIN ad_info a ON d.ad_id = a.ad_id;

-- --------------------------- df_user_modelling ----------------------------------------
-- create table df_user_modelling
DROP TABLE IF EXISTS df_user_modelling;
CREATE TABLE df_user_modelling
    SELECT txn_hour,
           txn_day_of_week,
           money,
           kind_pay,
           kind_card,
           network,
           industry,
           IF(gender IS NULL, 'unkonwn', gender) gender,
           clicked
    FROM df_user_joined;

-- --------------------------- df_user_agg_modelling ----------------------------------------
-- create table df_user_agg_modelling
DROP TABLE IF EXISTS df_user_agg_modelling;
CREATE TABLE df_user_agg_modelling
    SELECT COUNT(txn_timestamp) num_of_txn,
           txn_hour,
           txn_day_of_week,
           money,
           kind_pay,
           kind_card,
           network,
           industry,
           IF(gender IS NULL, 'unkonwn', gender) gender,
           clicked
    FROM df_user_joined
    GROUP BY user_id,
             txn_hour,
           txn_day_of_week,
           money,
           kind_pay,
           kind_card,
           network,
           industry,
           IF(gender IS NULL, 'unkonwn', gender),
           clicked;

