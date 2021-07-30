#Internet shop 4

db3.png - скрин схемы БД для интернет-магазина после доработки (СУБД Postgres + рефакторинг неймингов).
init.sql - скрипт создания БД, пользователя и схем.
create_data_model.sql - скрипт создания модели данных.
create_index.sql - скрипт создания индексов.

**Описание таблиц**

_customer_

    Таблица, описывающая покупателя.

    first_name - имя покупателя
    last_name - фамилия покупателя
    email - адрес электронной почты покупателя
    phone - телефон

_customer_order_

    Таблица, описывающая заказ/корзину.

    created_timestamp - дата и время формирования заказа (корзины)
    payed_timestamp - дата и время оплаты заказа
    total_price - сумма заказа
    total_discount - сумма общей скидки
    
    customer_id - индекс (FK)
    customer_order_status_id - индекс (FK)

_customer_order_status_

    Таблица, описывающая статусы заказа.

    name - имя статуса
    description - описание статуса

_customer_order_delivery_

    Таблица, описывающая доставку заказа.

    delivery_date - дата доставки заказа (или дата с которой достпуен заказ для самовывоза)
    delivery_info - информация по доставке

    customer_order_id - индекс (FK)
    delivery_type_id - индекс (FK)

_customer_delivery_location_

    Таблица связи один ко многим пользователя и его локаций.

    customer_id - индекс (FK)
    location_id - индекс (FK)

_pickup_delivery_location_

    Таблица, описывающая локации пунктов самовывоза заказов.

    location_id - индекс (FK)

_location_info_

    Таблица, ипсывающая локации мест.

    city - город
    street - улица
    building - дом, строение
    additional_info - дополнительна информация

_delivery_type_

    Таблица, описывающая варианты доставки.

    name - имя варианта доставки
    description - описание варианта доставки

_customer_order_detail_

    Таблица связи один ко многим заказа и подзаказов.

    customer_order_id - индекс (FK)
    customer_sub_order_id - индекс (FK)

_customer_sub_order_

    Таблица описывающая подзаказ (товар от конкретного поставщика в сочетании с его количеством)

    amount - количество товара

    supplier_product_price_id - индекс (FK)

_supplier_product_price_

    Таблица, описывающая историчность цен на товар у конкретного поставщика.

    start_date - дата, с которой цена вступает в силу
    price - цена товара

    supplier_product_id - индекс (FK)

_supplier_product_

    Таблица связи один ко многим товара и поставщиков для него.

    supplier_id - индекс (FK)
    product_id - индекс (FK)

_supplier_

    Таблица, описывающая поставщика.

    name - имя поставщика
    site - сайт поставщика
    email - электронная почта контактного лица
    phone - номер телефона контактного лица

_supplier_location_

    Таблица связи один к одному поставщика и его локации.

    supplier_id - индекс (FK)
    location_info_id - индекс (FK)

_product_

    Таблица, описывающая товар.

    name - имя товара
    article - артикул товара
    description - описание товара

    product_sale_type_id - индекс (FK)
    name - уникальный простой индекс
    article - уникальный простой индекс

_product_sale_type_

    Таблица, описывающая тип продажи товара (штучно, на вес)

    name - имя типа продажи
    short_name - сокращенное имя типа продажи

_product_margin_

    Таблица, описывающая наценку на конкретный товар

    margin - наценка

    product_id - индекс (FK)

_supplier_product_margin_

    Таблица, описывающая наценку на конкретный товар от конкретного поставщика

    margin - наценка

    supplier_product_id - индекс (FK)

_warehouse_detail_

    Таблица, описывающая количества товара от поставщика на складе

    amount - количество

    supplier_product_id - индекс (FK)

_product_category_

    Таблица связи многие ко многим товаров и их категорий

    product_id - индекс (FK)
    category_id - индекс (FK)

_category_

    Таблица, описывающая категорию товара

    name - имя категории
    description - описание категории

_product_customer_discount_

    Таблица, описывающая скидку покупателя на конкретный товар

    discount - процент скидки на товар
    start_date - дата начала действия скидки на товар
    finish_date - дата окончания действия скидки на товар

    supplier_product_id - индекс (FK)
    customer_id - индекс (FK)

    check_discount: discount > 0 AND discount < 1 AND start_date < finish_date

_category_customer_discount_

    Таблица, описывающая скидку покупателя на категорию товаров

    discount - процент скидки на товар
    start_date - дата начала действия скидки на товар
    finish_date - дата окончания действия скидки на товар

    category_id - индекс (FK)
    customer_id - индекс (FK)

    check_discount: discount > 0 AND discount < 1 AND start_date < finish_date

_product_discount_

    Таблица, описывающая скидку для всех на конкретный товар

    discount - процент скидки на товар
    start_date - дата начала действия скидки на товар
    finish_date - дата окончания действия скидки на товар

    supplier_product_id - индекс (FK)

    check_discount: discount > 0 AND discount < 1 AND start_date < finish_date

_category_discount_

    Таблица, описывающая скидку для всех на категорию товаров

    discount - процент скидки на товар
    start_date - дата начала действия скидки на товар
    finish_date - дата окончания действия скидки на товар

    category_id - индекс (FK)

    check_discount: discount > 0 AND discount < 1 AND start_date < finish_date