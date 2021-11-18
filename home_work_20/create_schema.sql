create schema customers;

use customers;

create table country
(
    country_id int not null auto_increment primary key,
    name       varchar(100)
) engine = InnoDB;

create table gender
(
    gender_id int not null auto_increment primary key,
    name      varchar(100)
) engine = InnoDB;

create table language
(
    language_id int not null auto_increment primary key,
    name        varchar(100)
) engine = InnoDB;

create table location
(
    location_id     int not null auto_increment primary key,
    postal_code     varchar(100),
    city            varchar(100),
    region          varchar(100),
    street          varchar(100),
    building_number varchar(100),
    country_id         int
) engine = InnoDB;

create table marital_status
(
    marital_status_id int not null auto_increment primary key,
    name              varchar(100)
) engine = InnoDB;

create table title
(
    title_id int not null auto_increment primary key,
    name     varchar(100)
) engine = InnoDB;

create table customer
(
    customer_id             int not null auto_increment primary key,
    first_name              varchar(100),
    last_name               varchar(100),
    birth_date              date,
    correspondence_language_id int,
    gender_id                  int,
    location_id                int,
    marital_status_id          int,
    title_id                   int
) engine = InnoDB;

alter table location
    add constraint fk_location_country foreign key (country_id) references country (country_id);

alter table customer
    add constraint fk_customer_language foreign key (correspondence_language_id) references language (language_id);

alter table customer
    add constraint fk_customer_gender foreign key (gender_id) references gender (gender_id);

alter table customer
    add constraint fk_customer_location foreign key (location_id) references location (location_id);

alter table customer
    add constraint fk_customer_marital_status foreign key (marital_status_id) references marital_status (marital_status_id);

alter table customer
    add constraint fk_customer_title foreign key (title_id) references title (title_id);