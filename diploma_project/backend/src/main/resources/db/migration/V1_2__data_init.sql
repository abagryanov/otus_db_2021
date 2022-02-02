-- Заполняем возможные роли пользователей
insert into customer.role (name, description)
values ('USER', 'Simple customer role'),
       ('SUPPLIER', 'Supplier role'),
       ('MANAGER', 'Manager role'),
       ('ADMIN', 'Administrative role');

-- Заполняем справочник типов продаж товаров
insert into product.product_sale_type (name, short_name)
values ('ПОШТУЧНО', 'ШТ'),
       ('В РАЗВЕС', 'КГ');

-- Заполняем справочник категорий товаров
insert into product.category (name, description)
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
insert into company.delivery_type (name, description)
values ('САМОВЫВОЗ', 'САМОВЫВОЗ ИЗ ПУНКТА ВЫДАЧИ'),
       ('ДОСТАВКА', 'ДОСТАВКА ПО АДРЕСУ');

-- Заполняем справочник статусов заказа
insert into customer.customer_order_status (name, description)
values ('СОЗДАН', 'КОРЗИНА ТОВАРОВ СОЗДАНА'),
       ('ОПЛАЧЕН', 'ЗАКАЗ ОПЛАЧЕН'),
       ('ФОРМИРОВАНИЕ', 'ЗАКАЗ ФОРМИРУЕТСЯ'),
       ('СФОРМИРОВАН', 'ЗАКАЗ СФОРМИРОВАН'),
       ('ГОТОВ К ВЫДАЧЕ', 'ЗАКАЗ ГОТОВ К ВЫДАЧЕ НА СКЛАДЕ'),
       ('ДОСТАВКА', 'ЗАКАЗ ДОСТАВЛЯЕТСЯ'),
       ('ДОСТАВЛЕН', 'ЗАКАЗ ДОСТАВЛЕН');

-- Заполняем справочник поставщиков
insert into supplier.supplier (name, site, email, phone)
values ('ООО АГРОФИРМА 1', 'http://agro-company-1.ru', 'sales@agro-company-1.ru', '74951111111'),
       ('ООО КОКА-КОЛА РУС', 'http://coca-cola.ru', 'sales@coca-cola.ru', '74952222222'),
       ('ООО ПЯТЕРКА', 'http://5-ka.ru', 'sales@5-ka.ru', '74953333333'),
       ('ООО МИР ОДЕЖДЫ', 'http://mir-odezhdy.ru', 'sales@mir-odezhdy.ru', '74954444444'),
       ('ООО ДЕТСКИЙ МИР', 'http://det-mir.ru', 'sales@det-mir.ru', '74955555555'),
       ('ООО РОССИЙСКОЕ ЗЕРНО', 'http://rus-grain.ru', 'sales@rus-grain.ru', '74956666666');

-- Заполняем расположения поставщиков
insert into company.location_info (city, street, building, additional_info)
values ('РОСТОВ', 'ЛЕТНЯЯ', '1', 'ПЕРВЫЙ ВЪЕЗД'),
       ('ХИМКИ', 'ПРОМЫШЛЕННАЯ', '2', 'ПРОМЫШЛЕННАЯ ЗОНА 1'),
       ('МОСКВА', 'ЛЕНИНА', '3', '2 ПОДЪЕЗД'),
       ('КАЗАНЬ', 'ШВЕЙНАЯ', '4', 'ВЛАДЕНИЕ 3'),
       ('РЯЗАНЬ', 'КОМСОМОЛЬСКАЯ', '5', 'ВЛАДЕНИЕ 5'),
       ('КРАСНОДАР', 'КАЗАЧЬЯ', '6', 'ПРОМЫШЛЕННАЯ ЗОНА 6');

-- Заполянем связь поставщика с расположением
insert into supplier.supplier_location (supplier_id, location_info_id)
values (1, 1),
       (2, 2),
       (3, 3),
       (4, 4),
       (5, 5),
       (6, 6);

-- Заполняем товары
insert into product.product (name, article, description, product_sale_type_id)
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
insert into product.product_category (product_id, category_id)
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
insert into supplier.supplier_product (supplier_id, product_id)
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
insert into product.product_margin (margin, product_id)
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
insert into supplier.supplier_product_margin (margin, supplier_product_id)
values (2.75, 1),
       (2.0, 2),
       (2.8, 3);

-- Заполняем остатки товаров на складе
insert into company.warehouse_detail (amount, supplier_product_id)
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
insert into supplier.supplier_product_price (start_date, price, supplier_product_id)
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
insert into product.product_discount (discount, start_date, finish_date, supplier_product_id)
values (0.3, '2021-08-06', '2022-11-06', 1),
       (0.4, '2021-08-06', '2022-12-06', 2),
       (0.75, '2021-08-06', '2022-12-06', 3);

-- Заполняем значения скидок на категории товаров
insert into product.category_discount (discount, start_date, finish_date, category_id)
values (0.4, '2021-08-06', '2022-11-06', 1),
       (0.45, '2021-08-06', '2022-12-06', 2),
       (0.6, '2021-08-06', '2022-12-06', 3);

-- Заполняем адреса пунктов самовывоза
insert into company.location_info (city, street, building, additional_info)
values ('МОСКВА', 'ПРОМЫШЛЕННАЯ', '3', 'ОФИС №1'),
       ('МОСКВА', 'ДОСТАВОЧНАЯ', '4', 'ОФИС №2');

-- Регистрируем адреса пунктов самовывоза
insert into company.pickup_delivery_location (location_info_id)
values (7),
       (8);

