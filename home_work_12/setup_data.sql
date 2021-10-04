-- Заполняем справочник типов продаж товаров
insert into product_sale_type (name, short_name)
values ('ПОШТУЧНО', 'ШТ'),
       ('В РАЗВЕС', 'КГ');

-- Заполняем справочник категорий товаров
insert into category (name, description)
values ('НАПИТКИ', 'БЕЗАЛКОГОЛЬНЫЕ НАПИТКИ'),
       ('ОВОЩИ', 'ОВОЩИ'),
       ('ФРУКТЫ', 'ФРУКТЫ'),
       ('КРУПЫ', 'КРУПЫ'),
       ('КАНЦЕЛЯРИЯ', 'КАНЦЕЛЯРСКИЕ ТОВАРЫ'),
       ('ОБУВЬ', 'ОБУВЬ'),
       ('ВЕРХНЯЯ ОДЕЖДА', 'ВЕРХНЯЯ ОДЕЖДА'),
       ('ДЛЯ ДЕТЕЙ', 'ТОВАРЫ ДЛЯ ДЕТЕЙ'),
       ('ДЛЯ МУЖЧИН', 'ТОВАРЫ ДЛЯ МУЖЧИН'),
       ('ДЛЯ ЖЕНЩИН', 'ТОВАРЫ ДЛЯ ЖЕНЩИН');

-- Заполняем справочник типов доставки
insert into delivery_type (name, description)
values ('САМОВЫВОЗ', 'САМОВЫВОЗ ИЗ ПУНКТА ВЫДАЧИ'),
       ('ДОСТАВКА', 'ДОСТАВКА ПО АДРЕСУ');

-- Заполняем справочник статусов заказа
insert into customer_order_status (name, description)
values ('СОЗДАН', 'КОРЗИНА ТОВАРОВ СОЗДАНА'),
       ('ОПЛАЧЕН', 'ЗАКАЗ ОПЛАЧЕН'),
       ('ФОРМИРОВАНИЕ', 'ЗАКАЗ ФОРМИРУЕТСЯ'),
       ('СФОРМИРОВАН', 'ЗАКАЗ СФОРМИРОВАН'),
       ('ГОТОВ К ВЫДАЧЕ', 'ЗАКАЗ ГОТОВ К ВЫДАЧЕ НА СКЛАДЕ'),
       ('ДОСТАВКА', 'ЗАКАЗ ДОСТАВЛЯЕТСЯ'),
       ('ДОСТАВЛЕН', 'ЗАКАЗ ДОСТАВЛЕН');

-- Заполняем справочник поставщиков
insert into supplier (name, site, email, phone)
values ('ООО АГРОФИРМА 1', 'http://agro-company-1.ru', 'sales@agro-company-1.ru', '74951111111'),
       ('ООО КОКА-КОЛА РУС', 'http://coca-cola.ru', 'sales@coca-cola.ru', '74952222222'),
       ('ООО ПЯТЕРКА', 'http://5-ka.ru', 'sales@5-ka.ru', '74953333333'),
       ('ООО МИР ОДЕЖДЫ', 'http://mir-odezhdy.ru', 'sales@mir-odezhdy.ru', '74954444444'),
       ('ООО ДЕТСКИЙ МИР', 'http://det-mir.ru', 'sales@det-mir.ru', '74955555555'),
       ('ООО РОССИЙСКОЕ ЗЕРНО', 'http://rus-grain.ru', 'sales@rus-grain.ru', '74956666666');

-- Заполняем расположения поставщиков
insert into location_info (city, street, building, additional_info)
values ('РОСТОВ', 'ЛЕТНЯЯ', '1', 'ПЕРВЫЙ ВЪЕЗД'),
       ('ХИМКИ', 'ПРОМЫШЛЕННАЯ', '2', 'ПРОМЫШЛЕННАЯ ЗОНА 1'),
       ('МОСКВА', 'ЛЕНИНА', '3', '2 ПОДЪЕЗД'),
       ('КАЗАНЬ', 'ШВЕЙНАЯ', '4', 'ВЛАДЕНИЕ 3'),
       ('РЯЗАНЬ', 'КОМСОМОЛЬСКАЯ', '5', 'ВЛАДЕНИЕ 5'),
       ('КРАСНОДАР', 'КАЗАЧЬЯ', '6', 'ПРОМЫШЛЕННАЯ ЗОНА 6');
-- Заполянем связь поставщика с расположением
insert into supplier_location (supplier_id, location_info_id)
values (1, 1),
       (2, 2),
       (3, 3),
       (4, 4),
       (5, 5),
       (6, 6);

-- Заполняем товары
insert into product (name, article, description, product_sale_type_id)
values ('ТОМАТЫ СЛИВОВИДНЫЕ', '000001', 'ТОМАТЫ КРАСНЫЕ, СЛИВОВИДНЫЕ', 2),
       ('COCA-COLA 0.33 Л', '000002', 'ГАЗИРОВАННЯА ВОДА COCA-COLA 0.33 Л', 1),
       ('ЯБЛОКИ АНТОНОВКА', '000003', 'ЯБЛОКИ СОРТА АНТОНОВКА', 2),
       ('ГРЕЧНЕВАЯ КРУПА', '000004', 'КРУПА ГРЕЧНЕВАЯ', 1),
       ('РУЧКА PARKER (СИНЯЯ)', '000005', 'РУЧКА PARKER ДЛЯ ППСЬМА С СИНИМИ ЧЕРНИЛАМИ', 1),
       ('КАША РИСОВАЯ АГУША', '000006', 'КРУПА АГУША РИСОВАЯ ДЛЯ ДЕТЕЙ', 1),
       ('NIKE AIR-MAX', '000007', 'КРОССОВКИ МУЖСКИЕ NIKE AIR-MAX', 1),
       ('КУРТКА ADIDAS-PRO', '000008', 'КУРТКА ЖЕНСКАЯ ADIDAS-PRO', 1),
       ('ЖУРНАЛ BARBIE', '000009', 'ЖУРНАЛ BARBIE С НАКЛЕЙКАМИ ДЛЯ ДЕВОЧЕК', 1);

-- Заподняем связи товара и категорий
insert into product_category (product_id, category_id)
values (1, 2),
       (2, 1),
       (3, 3),
       (4, 4),
       (5, 5),
       (6, 4),
       (6, 8),
       (7, 6),
       (7, 9),
       (8, 7),
       (8, 10),
       (9, 5),
       (9, 8),
       (9, 10);

-- Заполняем связь товара и поставщика
insert into supplier_product (supplier_id, product_id)
values (1, 1),
       (2, 2),
       (1, 3),
       (6, 4),
       (3, 5),
       (5, 6),
       (4, 7),
       (4, 8),
       (5, 9);

-- Заполняем значения маржи для товаров
insert into product_margin (margin, product_id)
values (3.0, 1),
       (2.5, 2),
       (3.0, 3),
       (2.0, 4),
       (1.5, 5),
       (4.0, 6),
       (2.5, 7),
       (3.0, 8),
       (2.0, 9);

-- Заполняем значения маржи для товаров от поставщика
insert into supplier_product_margin (margin, supplier_product_id)
values (2.75, 1),
       (2.0, 2),
       (2.8, 3);

-- Заполняем остатки товаров на складе
insert into warehouse_detail (amount, supplier_product_id)
values (100.0, 1),
       (200.0, 2),
       (300.0, 3),
       (400.0, 4),
       (500.0, 5),
       (600.0, 6),
       (700.0, 7),
       (800.0, 8),
       (900.0, 9);

-- Заполняем цены от поставщиков на конкретный товар
insert into supplier_product_price (start_date, price, supplier_product_id)
values ('2021-08-06', 100.0, 1),
       ('2021-08-06', 200.0, 2),
       ('2021-08-06', 300.0, 3),
       ('2021-08-06', 15.0, 4),
       ('2021-08-06', 20.0, 5),
       ('2021-08-06', 30.0, 6),
       ('2021-08-06', 40.0, 7),
       ('2021-08-06', 50.0, 8),
       ('2021-08-06', 700.0, 9);

-- Заполняем значения скидок на товары
insert into product_discount (discount, start_date, finish_date, supplier_product_id)
values (0.3, '2021-08-06', '2021-11-06', 1),
       (0.4, '2021-08-06', '2021-12-06', 2),
       (0.25, '2021-08-06', '2021-12-06', 3);

-- Заполняем значения скидок на категории товаров
insert into category_discount (discount, start_date, finish_date, category_id)
values (0.4, '2021-08-06', '2021-11-06', 1),
       (0.45, '2021-08-06', '2021-12-06', 2),
       (0.6, '2021-08-06', '2021-12-06', 3);

-- Заполняем пользователей
insert into customer (first_name, last_name, email, phone)
values ('ИВАН', 'ИВАНОВ', 'iivanov@gmail.com', '79261111111'),
       ('ПЕТР', 'ПЕТРОВ', 'ppetrov@gmail.com', '79262222222');

-- Заполняем скидку на конкртеный товар от поставщика для конкретного покупателя
insert into product_customer_discount (discount, start_date, finish_date, customer_id, supplier_product_id)
values (0.35, '2021-08-06', '2021-11-06', 1, 1),
       (0.45, '2021-08-06', '2021-12-06', 1, 2),
       (0.3, '2021-08-06', '2021-12-06', 1, 3),
       (0.37, '2021-08-06', '2021-11-06', 2, 1),
       (0.47, '2021-08-06', '2021-12-06', 2, 2),
       (0.32, '2021-08-06', '2021-12-06', 2, 3);

-- Заполняем скидку на категории для конкретного покупателя
insert into category_customer_discount (discount, start_date, finish_date, customer_id, category_id)
values ('0.42', '2021-08-06', '2021-11-06', 1, 1),
       ('0.47', '2021-08-06', '2021-12-06', 1, 2),
       ('0.62', '2021-08-06', '2021-12-06', 1, 3),
       ('0.44', '2021-08-06', '2021-11-06', 2, 1),
       ('0.49', '2021-08-06', '2021-12-06', 2, 2),
       ('0.64', '2021-08-06', '2021-12-06', 2, 3);

-- Заполняем подзаказы для заказов покупателей
insert into customer_sub_order (amount, supplier_product_price_id)
values (1.0, 1),
       (2.0, 2),
       (3.0, 3),
       (4.0, 4),
       (1.0, 5),
       (2.0, 6),
       (3.0, 7),
       (4.0, 8);

-- Заполняем заказы для покупателей
insert into customer_order (created_datetime, payed_datetime, total_price, total_discount, customer_id,
                                     customer_order_status_id)
values ('2021-08-06 12:30:30', '2021-08-06 12:35:40', 0.0, 0.0, 1, 2),
       ('2021-08-06 13:30:30', '2021-08-06 13:35:40', 0.0, 0.0, 2, 2);

-- Заполняем связи подзаказов с заказами покупателей
insert into customer_order_detail (customer_order_id, customer_sub_order_id)
values (1, 1),
       (1, 2),
       (1, 3),
       (1, 4),
       (2, 5),
       (2, 6),
       (2, 7),
       (2, 8);

-- Заполняем адреса покупателей
insert into location_info (city, street, building, additional_info)
values ('МОСКВА', 'СОЛНЕЧНАЯ', '1', '3-Й ПОДЪЕЗД, 12 ЭТАЖ, КВАРТИРА 25'),
       ('МОСКВА', 'СНЕЖНАЯ', '2', '1-Й ПОДЪЕЗД, 10 ЭТАЖ, КВАРТИРА 20');

-- Заполняем адреса пунктов самовывоза
insert into location_info (city, street, building, additional_info)
values ('МОСКВА', 'ПРОМЫШЛЕННАЯ', '3', 'ОФИС №1'),
       ('МОСКВА', 'ДОСТАВОЧНАЯ', '4', 'ОФИС №2');

-- Регистрируем адреса пунктов самовывоза
insert into pickup_delivery_location (location_info_id)
values (9),
       (10);

-- Регистрируем адреса доставки заказов для покупателей
insert into customer_delivery_location (customer_id, location_info_id)
values (1, 7),
       (2, 8);

-- Заполняем доставки заказов
insert into customer_order_delivery (delivery_date, delivery_info, customer_order_id, delivery_type_id,
                                              pickup_delivery_location_id, customer_delivery_location_id)
values ('2021-08-15', 'ЗАБЕРУ ПОСЛЕ 18-00', 1, 1, 1, null),
       ('2021-08-20', 'ДОСТАВЬТЕ ПОСЛЕ 12-00 И ДО 16-00', 2, 2, null, 2);
