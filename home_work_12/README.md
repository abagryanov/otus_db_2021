#Otus internet shop (MySQL)

./create_data_model.sql - измененный скрипт создания схемы (поправлен тип numeric на numeric(10, 2));

./setup_data.sql - скрипт наполняющий данными БД. Взят из ДЗ по постгресу и поправлен в соответсвии с типами MySQL 
    (timestamp -> datetime).

Запросы:
    
    1) Напишите запрос по своей базе с inner join.
    select delivery_info from customer_order_delivery as delivery inner join customer_delivery_location 
    as delivery_location on delivery.customer_delivery_location_id = delivery_location.customer_delivery_location_id;

    Выбираем информацию о доставке из заказов, в которых указана доставка до покупателя.

    2) Напишите запрос по своей базе с left join
    select product.name, product.article, sale_type.name from product as product left join product_sale_type 
    as sale_type on product.product_sale_type_id = sale_type.product_sale_type_id;

    Выбираем информацию по товарам с типом продажи (поштучно, в развес).

    3) Напишите 5 запросов с WHERE с использованием разных операторов, опишите для чего вам в проекте 
    нужна такая выборка данных.

        3.1 select product.name, product.article from product left join product_category on 
            product.product_id = product_category.product_id where product_category.category_id = 3;
        
        Выбираем все товары с категорией фрукты

        3.2 select name, article from product where description like '%КРУПА%';
        
        Выбираем товары с описанием крупы.

        3.3 select category.name from product_category left join category on 
            product_category.category_id = category.category_id where product_category.product_id in 
            (select product_id from product where description like '%КРУПА%');

        Выбираем наименования категорий товаров, которые являются крупами.

        3.4 select customer_order_delivery_id from customer_order_delivery where customer_delivery_location_id is not null;

        Выбираем доставки для покупателей, которые должны быть доставлены до покупателя

        3.5 select warehouse_detail.supplier_product_id, product.name, product.article from warehouse_detail left join 
            supplier_product on warehouse_detail.supplier_product_id = supplier_product.supplier_product_id left join 
            product on supplier_product.product_id = product.product_id where amount <= 100.0;
        
        Выбираем на складе товары в разрезе поставщика с малым запасом. Также выводим артикул и наименование продукта
        для возможности заказа у другого поставщика, если данный не может организовать поставку.