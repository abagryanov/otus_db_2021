#Internet shop 5

    * Исправлены типы данных в модели (./home_work_4/create_data_model.sql)
        - Изменен тип primary key в таблицах на serial;
        - Изменен тип цен, скидок и маржей на numeric;

    * Реализован скрипт заполнения модели данными (./setup_data.sql)

Домашнее задание

    1) Напишите запрос по своей базе с регулярным выражением, добавьте пояснение, что вы хотите найти.
        - select name, article from product.product where description like '%КРУПА%';
        - select name, article from product.product where description ~* 'крупа';
        (выбираем все товары, которые являются крупами)

    2) Напишите запрос по своей базе с использованием LEFT JOIN и INNER JOIN, как порядок соединений в FROM влияет на результат? Почему?
        - select product.name, product.article, sale_type.name from product.product as product left join product.product_sale_type as sale_type on product.product_sale_type_id = sale_type.product_sale_type_id;
        - select delivery.delivery_info from customer.customer_order_delivery as delivery inner join customer.customer_delivery_location as delivery_location on delivery.customer_delivery_location_id = delivery_location.customer_delivery_location_id;
        При явном указании выбираемых полей порядок соединения не влияет на результат. При выборке всех полей (*) результат меняется таким образом, что сначала выводятся все солбцы первой таблицы, а затем второй.

    3) Напишите запрос на добавление данных с выводом информации о добавленных строках.
        - insert into customer.customer (first_name, last_name, email, phone) values ('ТЕСТ', 'ТЕСТОВ', 'ttest@gmail.com', '79260000000') returning customer_id;
        Добавляет нового покупателя и выводит его ИД.

    4) Напишите запрос с обновлением данные используя UPDATE FROM.
        создадим тестовую запись в таблице доставки заказов клиенту:
        insert into customer.customer_order_delivery (delivery_date, delivery_info, customer_order_id, delivery_type_id, pickup_delivery_location_id, customer_delivery_location_id) values ('2021-08-15', 'ТЕСТ', 1, 1, null, null);
        
        По условию в магазине не может быть варианта где заказ не имеет связи с пользовательским адресом или с адресом пункта самовывоза.
        Выберем записи, которые не имеют связи с пользовательским адресом доставки и не имеют связи с адресом пункта самовывоза и проставим сввязь с первым пунктом самовывоза.
        
        update customer.customer_order_delivery 
        set pickup_delivery_location_id = 1
        from (select customer_order_delivery.pickup_delivery_location_id from customer.customer_order_delivery
        where customer.customer_order_delivery.customer_delivery_location_id is null and customer.customer_order_delivery.pickup_delivery_location_id is null) oreder_delivery;

    5) Напишите запрос для удаления данных с оператором DELETE используя join с другой таблицей с помощью using.
        delete from customer.customer_order_delivery as order_delivery
        using company.pickup_delivery_location as pickup_location
        where order_delivery.pickup_delivery_location_id = pickup_location.pickup_delivery_location_id and
        order_delivery.delivery_info ~* 'тест' and
        pickup_location.location_info_id = 9;

    6) Приведите пример использования утилиты COPY
        С помощью утилиты COPY можно сохранять (и считывать) данные таблиц в файл. С ее помощью можно сделать следующее:
            - перенести данные из одной БД в другую
            - сделать свой бэкап данных
            - в текстовом редакторе удобно подготовить справочные данные для загрузки