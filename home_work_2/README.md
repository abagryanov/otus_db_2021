#Internet shop 2

db2.png - скрин схемы БД для интернет-магазина после доработки.

https://app.sqldbm.com/MySQL/Edit/p175790/ - ссылка на источник.

**Описание таблиц**

_Customer_
    
    Таблица, описывающая покупателя.

    first_name - имя покупателя
    last_name - фамилия покупателя
    email - адрес электронной почты покупателя
    phone - телефон

_Order_

    Таблица, описывающая заказ/корзину.

    created_datetime - дата и время формирования заказа (корзины)
    payed_datetime - дата и время оплаты заказа
    total_price - сумма заказа
    total_discount - сумма общей скидки
    
    customer_id - индекс (FK)
    order_status_id - индекс (FK)

_OrderStatus_

    Таблица, описывающая статусы заказа.

    name - имя статуса
    description - описание статуса

_OrderDelivery_

    Таблица, описывающая доставку заказа.

    delivery_date - дата доставки заказа (или дата с которой достпуен заказ для самовывоза)
    delivery_info - информация по доставке

    order_id - индекс (FK)
    delivery_type_id - индекс (FK)

_CustomerDeliveryLocation_

    Таблица связи один ко многим пользователя и его локаций.

    customer_id - индекс (FK)
    location_id - индекс (FK)

_PickupDeliveryLocation_

    Таблица, описывающая локации пунктов самовывоза заказов.

    location_id - индекс (FK)

_Location_

    Таблица, ипсывающая локации мест.

    city - город
    street - улица
    building - дом, строение
    additional_info - дополнительна информация

_DeliveryType_

    Таблица, описывающая варианты доставки.

    name - имя варианта доставки
    description - описание варианта доставки

_OrderDetail_

    Таблица связи один ко многим заказа и подзаказов.

    order_id - индекс (FK)
    sub_order_id - индекс (FK)

_SubOrder_

    Таблица описывающая подзаказ (товар от конкретного поставщика в сочетании с его количеством)

    amount - количество товара

    supplier_product_price_id - индекс (FK)

_SupplierProductPrice_

    Таблица, описывающая историчность цен на товар у конкретного поставщика.

    start_date - дата, с которой цена вступает в силу
    price - цена товара

    supplier_product_id - индекс (FK)

_SupplierProduct_

    Таблица связи один ко многим товара и поставщиков для него.

    supplier_id - индекс (FK)
    product_id - индекс (FK)

_Supplier_

    Таблица, описывающая поставщика.

    name - имя поставщика
    site - сайт поставщика
    email - электронная почта контактного лица
    phone - номер телефона контактного лица

_SupplierLocation_

    Таблица связи один к одному поставщика и его локации.

    supplier_id - индекс (FK)
    location_id - индекс (FK)

_Product_

    Таблица, описывающая товар.

    name - имя товара
    article - артикул товара
    description - описание товара

    product_sale_type_id - индекс (FK)
    name - уникальный простой индекс
    article - уникальный простой индекс

_ProductSaleType_

    Таблица, описывающая тип продажи товара (штучно, на вес)

    name - имя типа продажи
    short_name - сокращенное имя типа продажи

_ProductMargin_

    Таблица, описывающая наценку на конкретный товар

    margin - наценка

    product_id - индекс (FK)

_SupplierProductMargin_

    Таблица, описывающая наценку на конкретный товар от конкретного поставщика

    margin - наценка

    supplier_product_id - индекс (FK)

_WarehouseDetail_

    Таблица, описывающая количества товара от поставщика на складе

    amount - количество

    supplier_product_id - индекс (FK)

_ProductCategory_

    Таблица связи многие ко многим товаров и их категорий

    product_id - индекс (FK)
    category_id - индекс (FK)

_Category_

    Таблица, описывающая категорию товара

    name - имя категории
    description - описание категории

_ProductCustomerDiscount_

    Таблица, описывающая скидку покупателя на конкретный товар

    discount - процент скидки на товар
    start_date - дата начала действия скидки на товар
    finish_date - дата окончания действия скидки на товар

    supplier_product_id - индекс (FK)
    customer_id - индекс (FK)

    check_discount: discount > 0 AND discount < 1 AND start_date < finish_date

_CategoryCustomerDiscount_

    Таблица, описывающая скидку покупателя на категорию товаров

    discount - процент скидки на товар
    start_date - дата начала действия скидки на товар
    finish_date - дата окончания действия скидки на товар

    category_id - индекс (FK)
    customer_id - индекс (FK)

    check_discount: discount > 0 AND discount < 1 AND start_date < finish_date

_ProductDiscount_

    Таблица, описывающая скидку для всех на конкретный товар

    discount - процент скидки на товар
    start_date - дата начала действия скидки на товар
    finish_date - дата окончания действия скидки на товар

    supplier_product_id - индекс (FK)

    check_discount: discount > 0 AND discount < 1 AND start_date < finish_date

_CategoryDiscount_

    Таблица, описывающая скидку для всех на категорию товаров

    discount - процент скидки на товар
    start_date - дата начала действия скидки на товар
    finish_date - дата окончания действия скидки на товар

    category_id - индекс (FK)

    check_discount: discount > 0 AND discount < 1 AND start_date < finish_date