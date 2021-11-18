

use customers;

create table if not exists csv_table
(
    id                      int auto_increment primary key,
    title                   varchar(100),
    first_name              varchar(100),
    last_name               varchar(100),
    correspondence_language varchar(100),
    birth_date              varchar(100),
    gender                  varchar(100),
    marital_status          varchar(100),
    country                 varchar(100),
    postal_code             varchar(100),
    region                  varchar(100),
    city                    varchar(100),
    street                  varchar(100),
    building_number         varchar(100)
);

load data local infile 'C:/Users/ABagryanov/IdeaProjects/otus_db_2021/home_work_20/csv/some_customers.csv' into table csv_table
    fields terminated by ','
    enclosed by '"'
    lines terminated by '\n'
    ignore 1 rows
(title, first_name, last_name, correspondence_language, birth_date, gender, marital_status, country, postal_code,
    region, city, street, building_number);