create database if not exists otus_internet_shop;
use otus_internet_shop;

create table customer
(
    customer_id int primary key auto_increment,
    first_name  varchar(50) not null,
    last_name   varchar(50),
    email       varchar(50) not null,
    phone       varchar(50) not null
);

create table customer_order_status
(
    customer_order_status_id int primary key auto_increment,
    name                     varchar(50) not null,
    description              text
);

create table delivery_type
(
    delivery_type_id int primary key auto_increment,
    name             varchar(50) not null,
    description      text
);

create table customer_order
(
    customer_order_id        int primary key auto_increment,
    created_datetime        datetime,
    payed_datetime          datetime,
    total_price              numeric,
    total_discount           numeric,
    customer_id              int not null,
    customer_order_status_id int not null,
    constraint FK_CustomerOrder_CustomerId foreign key (customer_id) references customer (customer_id),
    constraint FK_CustomerOrder_OrderStatusId foreign key (customer_order_status_id) references customer_order_status (customer_order_status_id)
);

create table location_info
(
    location_info_id int primary key auto_increment,
    city             varchar(50) not null,
    street           varchar(50) not null,
    building         varchar(50) not null,
    additional_info  text
);

create table pickup_delivery_location
(
    pickup_delivery_location_id int primary key auto_increment,
    location_info_id            int not null,
    constraint FK_PickupDeliveryLocation_LocationInfoId foreign key (location_info_id) references location_info (location_info_id)
);

create table customer_delivery_location
(
    customer_delivery_location_id int primary key auto_increment,
    customer_id                   int not null,
    location_info_id              int not null,
    constraint FK_CustomerDeliveryLocation_LocationInfoId foreign key (location_info_id) references location_info (location_info_id),
    constraint FK_CustomerDeliveryLocation_CustomerId foreign key (customer_id) references customer (customer_id)
);

create table customer_order_delivery
(
    customer_order_delivery_id    int primary key auto_increment,
    delivery_date                 date   not null,
    delivery_info                 text,
    customer_order_id             int not null,
    delivery_type_id              int not null,
    pickup_delivery_location_id   int,
    customer_delivery_location_id int,
    constraint FK_CustomerOrderDelivery_CustomerOrderId foreign key (customer_order_id) references customer_order (customer_order_id),
    constraint FK_CustomerOrderDelivery_DeliveryTypeId foreign key (delivery_type_id) references delivery_type (delivery_type_id),
    constraint FK_CustomerOrderDelivery_PickupDeliveryLocationId foreign key (pickup_delivery_location_id) references pickup_delivery_location (pickup_delivery_location_id),
    constraint FK_CustomerOrderDelivery_CustomerDeliveryLocationId foreign key (customer_delivery_location_id) references customer_delivery_location (customer_delivery_location_id)
);

create table product_sale_type
(
    product_sale_type_id int primary key auto_increment,
    name                 varchar(50) not null,
    short_name           varchar(5)  not null
);

create table product
(
    product_id           int primary key auto_increment,
    name                 varchar(50) not null,
    article              varchar(50) not null,
    description          text,
    product_sale_type_id int      not null,
    constraint FK_Product_ProductSaleTypeId foreign key (product_sale_type_id) references product_sale_type (product_sale_type_id)
);

create table product_margin
(
    product_margin_id int primary key auto_increment,
    margin            numeric not null,
    product_id        int  not null,
    constraint FK_ProductMargin_ProductId foreign key (product_id) references product (product_id)
);

create table category
(
    category_id int primary key auto_increment,
    name        varchar(50) not null,
    description text
);

create table product_category
(
    product_category_id int primary key auto_increment,
    product_id          int not null,
    category_id         int not null,
    constraint FK_ProductCategory_ProductId foreign key (product_id) references product (product_id),
    constraint FK_ProductCategory_CategoryId foreign key (category_id) references category (category_id)
);

create table supplier
(
    supplier_id int primary key auto_increment,
    name        varchar(50) not null,
    site        varchar(50),
    email       varchar(50),
    phone       varchar(50)
);

create table supplier_product
(
    supplier_product_id int primary key auto_increment,
    supplier_id         int not null,
    product_id          int not null,
    constraint FK_SupplierProduct_SupplierId foreign key (supplier_id) references supplier (supplier_id),
    constraint FK_SupplierProduct_ProductId foreign key (product_id) references product (product_id)
);

create table supplier_location
(
    supplier_location_id int primary key auto_increment,
    supplier_id          int not null,
    location_info_id     int not null,
    constraint FK_SupplierLocation_SupplierId foreign key (supplier_id) references supplier (supplier_id),
    constraint FK_SupplierLocation_LocationInfoId foreign key (location_info_id) references location_info (location_info_id)
);

create table supplier_product_price
(
    supplier_product_price_id int primary key auto_increment,
    start_date                date    not null,
    price                     numeric not null,
    supplier_product_id       int  not null,
    constraint FK_SupplierProductPrice_SupplierProductId foreign key (supplier_product_id) references supplier_product (supplier_product_id)
);

create table customer_sub_order
(
    customer_sub_order_id     int primary key auto_increment,
    amount                    numeric not null,
    supplier_product_price_id int  not null,
    constraint FK_CustomerSubOrder_SupplierProductPriceId foreign key (supplier_product_price_id) references supplier_product_price (supplier_product_price_id)
);

create table customer_order_detail
(
    customer_order_detail_id int primary key auto_increment,
    customer_order_id        int not null,
    customer_sub_order_id    int not null,
    constraint FK_CustomerOrderDetail_CustomerOrderId foreign key (customer_order_id) references customer_order (customer_order_id),
    constraint FK_CustomerOrderDetail_CustomerSubOrderId foreign key (customer_sub_order_id) references customer_sub_order (customer_sub_order_id)
);

create table supplier_product_margin
(
    supplier_product_margin_id int primary key auto_increment,
    margin                     numeric not null,
    supplier_product_id        int  not null,
    constraint FK_SupplierProductMargin_SupplierProductId foreign key (supplier_product_id) references supplier_product (supplier_product_id)
);

create table product_discount
(
    product_discount_id int primary key auto_increment,
    discount            numeric not null,
    start_date          date    not null,
    finish_date         date    not null,
    supplier_product_id int  not null,
    constraint FK_ProductDiscount_SupplierProductId foreign key (supplier_product_id) references supplier_product (supplier_product_id),
    constraint ProductDiscount_CheckDiscount check ( discount > 0 and discount < 1 and start_date < finish_date )
);

create table category_discount
(
    category_discount_id int primary key auto_increment,
    discount             numeric not null,
    start_date           date    not null,
    finish_date          date    not null,
    category_id          int  not null,
    constraint FK_ProductCategoryDiscount_SupplierProductId foreign key (category_id) references category (category_id),
    constraint CategoryDiscount_CheckDiscount check ( discount > 0 and discount < 1 and start_date < finish_date )
);

create table category_customer_discount
(
    product_category_discount_id int primary key auto_increment,
    discount                     numeric not null,
    start_date                   date    not null,
    finish_date                  date    not null,
    customer_id                  int  not null,
    category_id                  int  not null,
    constraint FK_CategoryCustomerDiscount_CustomerId foreign key (customer_id) references customer (customer_id),
    constraint FK_CategoryCustomerDiscount_CategoryId foreign key (category_id) references category (category_id),
    constraint CategoryCustomerDiscount_CheckDiscount check ( discount > 0 and discount < 1 and start_date < finish_date )
);

create table product_customer_discount
(
    product_customer_discount_id int primary key auto_increment,
    discount                     numeric not null,
    start_date                   date    not null,
    finish_date                  date    not null,
    customer_id                  int  not null,
    supplier_product_id          int  not null,
    constraint FK_ProductCustomerDiscount_CustomerId foreign key (customer_id) references customer (customer_id),
    constraint FK_ProductCustomerDiscount_CategoryId foreign key (supplier_product_id) references supplier_product (supplier_product_id),
    constraint ProductCustomerDiscount_CheckDiscount check ( discount > 0 and discount < 1 and start_date < finish_date )
);

create table warehouse_detail
(
    warehouse_detail_id int primary key auto_increment,
    amount              numeric not null,
    supplier_product_id int  not null,
    constraint FK_WareHouseDetail_SupplierProductId foreign key (supplier_product_id) references supplier_product (supplier_product_id)
);

