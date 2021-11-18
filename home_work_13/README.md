# Otus internet shop. Transactions + stored procedure (MySQL) 

1) Описать пример транзакции из своего проекта с изменением данных в нескольких таблицах. Реализовать в виде хранимой процедуры.
    
        В ./sql/create_customer_order_procedure.sql реализована хранимая процедура, которая создает пользовательский 
        заказ в рамках проектной модели данных. Предварительно данные заливаются из ./sql/setup_data.sql.
        Пример вызова процедуры: 
        call customer_order(1, '[{"supplier_product_id":1,"amount":2},{"supplier_product_id":2,"amount":3}]', true, 1, 
        date(now()), 'test_text', @result);

2) Загрузить данные из приложенных в материалах csv.
        
    a. LOAD DATA
      В MySQL workbench настраиваем коннект: Database -> Manage Connections -> Выбираем соединение -> Connection (Advanced)
      -> Дописываем: OPT_LOCAL_INFILE=1. Также в консоли выполняем: SET GLOBAL local_infile=1;
   
      В консоли:
         create database test;
         use test;
         create table apparel (
         id int primary key auto_increment,
         Handle varchar(50),
         Title varchar(50)
         );

         load data local infile 'C:/Users/ABagryanov/IdeaProjects/otus_db_2021/home_work_13/load/Apparel.csv' into table apparel
         fields terminated by ','
         enclosed by '"'
         lines terminated by '\n'
         ignore 1 rows
         (Handle, Title);

    b. mysqlimport

      mysqlimport --host=localhost --port=3309 --user=root --password=12345 \
      --columns=Handle,Title --fields-optionally-enclosed-by=\" --fields-terminated-by=\, --fields-escaped-by=\' \
      --lines-terminated-by=\n --ignore-lines=1 --local test \
      C:\Users\ABagryanov\IdeaProjects\otus_db_2021\home_work_13\load\Apparel.csv