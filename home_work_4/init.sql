create user otus with encrypted password 'otus';
create database otus_internet_shop owner otus;
\connect otus_internet_shop;
create schema if not exists company authorization otus;
create schema if not exists product authorization otus;
create schema if not exists customer authorization otus;
create schema if not exists supplier authorization otus;