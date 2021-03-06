#Internet shop 1

db1.png - скрин схемы БД для интернет-магазина.

https://app.sqldbm.com/MySQL/Edit/p175790/ - ссылка на источник.

**Описание таблиц**

_Customer_
    
    Таблица, описывающая покупателя.

    first_name - имя покупателя
    last_name - фамилия покупателя
    email - адрес электронной почты покупателя

_Order_

    Таблица, описывающая заказ/корзину.

    created - дата и время формирования заказа (корзины)
    payed - дата и время оплаты заказа
    total_price - сумма заказа
    total_discount - сумма общей скидки

_OrderDelivery_

    Таблица, описывающая доставку заказа.

    delivery_date - дата доставки заказа (или дата с которой достпуен заказ для самовывоза)
    delivery_info - информация по доставке

_DeliveryType_

    Таблица, описывающая варианты доставки.

    delivery_type_name - имя варианта доставки

_OrderProduct_

    Таблица связи один ко многим заказа и товаров с ценой у конкретного поставщика.

_SupplierProductPrice_

    Таблица, описывающая историчность цен на товар у конкретного поставщика.

    start_date - дата, с которой цена вступает в силу
    price - цена товара

_SupplierProduct_

    Таблица связи один ко многим товара и поставщиков для него.

_Supplier_

    Таблица, описывающая поставщика.

    supplier_name - имя поставщика
    supplier_location - расположение поставщика
    supplier_site - сайт поставщика

_Product_

    Таблица, описывающая товар.

    name - имя товара
    article - артикул товара
    description - описание товара

_ProductCategory_

    Таблица связи многие ко многим товаров и их категорий

_Category_

    Таблица, описывающая категорию товара

    category_name - имя категории
    category_description - описание категории

_ProductCustomerDiscount_

    Таблица, описывающая скидку покупателя на конкретный товар

    discount - процент скидки на товар
    start_date - дата начала действия скидки на товар
    finish_date - дата окончания действия скидки на товар

_CategoryCustomerDiscount_

    Таблица, описывающая скидку покупателя на категорию товаров

    discount - процент скидки на товар
    start_date - дата начала действия скидки на товар
    finish_date - дата окончания действия скидки на товар