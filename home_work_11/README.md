# Partition table (MySQL)

В проекте пока не предусмотрена таблица с пртиционированием. Выполняем ДЗ на тестовой таблице.

    Создание таблицы:
    create database if not exists test;
    use test;
    create table test_range
    (
        value int not null
    ) partition by range (value) 
    (
        partition p0 values less than (10),
        partition p1 values less than (20),
        partition p2 values less than (MAXVALUE)
    );

    Заполнение таблицы:
    insert into test_range(value) values (5), (7), (10), (12), (15), (20), (25), (30), (100), (1000);

    Запрос по партициям:
    select p.partition_name, p.table_rows from information_schema.partitions p where table_name = 'test_range';

    Ответ:
    p0	2
    p1	3
    p2	5