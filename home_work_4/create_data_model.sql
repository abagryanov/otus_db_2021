\connect otus_internet_shop;

CREATE TABLE customer.customer
(
    "customer_id" bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    "first_name"  varchar(50) NOT NULL,
    "last_name"   varchar(50),
    "email"       varchar(50) NOT NULL,
    "phone"       varchar(50) NOT NULL
);

CREATE TABLE customer.customer_order_status
(
    "customer_order_status_id" bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    "name"            varchar(50) NOT NULL,
    "description"     text
);

CREATE TABLE company.delivery_type
(
    "delivery_type_id" bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    "name"             varchar(50) NOT NULL,
    "description"      text
);

CREATE TABLE customer.customer_order
(
    "customer_order_id" bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    "created_timestamp" timestamp,
    "payed_timestamp"   timestamp,
    "total_price"       real,
    "total_discount"    real,
    "customer_id"       bigint NOT NULL,
    "customer_order_status_id"   bigint NOT NULL,
    CONSTRAINT "FK_CustomerOrder_CustomerId" FOREIGN KEY ("customer_id") REFERENCES customer.customer ("customer_id"),
    CONSTRAINT "FK_CustomerOrder_OrderStatusId" FOREIGN KEY ("customer_order_status_id") REFERENCES customer.customer_order_status ("customer_order_status_id")
);

CREATE TABLE company.location_info
(
    "location_info_id" bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    "city"             varchar(50) NOT NULL,
    "street"           varchar(50) NOT NULL,
    "building"         varchar(50) NOT NULL,
    "additional_info"  text
);

CREATE TABLE company.pickup_delivery_location
(
    "pickup_delivery_location_id" bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    "location_info_id"            bigint NOT NULL,
    CONSTRAINT "FK_PickupDeliveryLocation_LocationInfoId" FOREIGN KEY ("location_info_id") REFERENCES company.location_info ("location_info_id")
);

CREATE TABLE customer.customer_delivery_location
(
    "customer_delivery_location_id" bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    "customer_id"                   bigint NOT NULL,
    "location_info_id"              bigint NOT NULL,
    CONSTRAINT "FK_CustomerDeliveryLocation_LocationInfoId" FOREIGN KEY ("location_info_id") REFERENCES company.location_info ("location_info_id"),
    CONSTRAINT "FK_CustomerDeliveryLocation_CustomerId" FOREIGN KEY ("customer_id") REFERENCES customer.customer ("customer_id")
);

CREATE TABLE customer.customer_order_delivery
(
    "customer_order_delivery_id"    bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    "delivery_date"                 date   NOT NULL,
    "delivery_info"                 text,
    "customer_order_id"             bigint NOT NULL,
    "delivery_type_id"              bigint NOT NULL,
    "pickup_delivery_location_id"   bigint,
    "customer_delivery_location_id" bigint,
    CONSTRAINT "FK_CustomerOrderDelivery_CustomerOrderId" FOREIGN KEY ("customer_order_id") REFERENCES customer.customer_order ("customer_order_id"),
    CONSTRAINT "FK_CustomerOrderDelivery_DeliveryTypeId" FOREIGN KEY ("delivery_type_id") REFERENCES company.delivery_type ("delivery_type_id"),
    CONSTRAINT "FK_CustomerOrderDelivery_PickupDeliveryLocationId" FOREIGN KEY ("pickup_delivery_location_id") REFERENCES company.pickup_delivery_location ("pickup_delivery_location_id"),
    CONSTRAINT "FK_CustomerOrderDelivery_CustomerDeliveryLocationId" FOREIGN KEY ("customer_delivery_location_id") REFERENCES customer.customer_delivery_location ("customer_delivery_location_id")
);

CREATE TABLE product.product_sale_type
(
    "product_sale_type_id" bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    "name"                 varchar(50) NOT NULL,
    "short_name"           varchar(5)  NOT NULL
);

CREATE TABLE product.product
(
    "product_id"           bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    "name"                 varchar(50) NOT NULL,
    "article"              varchar(50) NOT NULL,
    "description"          text,
    "product_sale_type_id" bigint      NOT NULL,
    CONSTRAINT "FK_Product_ProductSaleTypeId" FOREIGN KEY ("product_sale_type_id") REFERENCES product.product_sale_type ("product_sale_type_id")
);

CREATE TABLE product.product_margin
(
    "product_margin_id" bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    "margin"            real   NOT NULL,
    "product_id"        bigint NOT NULL,
    CONSTRAINT "FK_ProductMargin_ProductId" FOREIGN KEY ("product_id") REFERENCES product.product ("product_id")
);

CREATE TABLE product.category
(
    "category_id" bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    "name"        varchar(50) NOT NULL,
    "description" text
);

CREATE TABLE product.product_category
(
    "product_category_id" bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    "product_id"          bigint NOT NULL,
    "category_id"         bigint NOT NULL,
    CONSTRAINT "FK_ProductCategory_ProductId" FOREIGN KEY ("product_id") REFERENCES product.product ("product_id"),
    CONSTRAINT "FK_ProductCategory_CategoryId" FOREIGN KEY ("category_id") REFERENCES product.category ("category_id")
);

CREATE TABLE supplier.supplier
(
    "supplier_id" bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    "name"        varchar(50) NOT NULL,
    "site"        varchar(50),
    "email"       varchar(50),
    "phone"       varchar(50)
);

CREATE TABLE supplier.supplier_product
(
    "supplier_product_id" bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    "supplier_id"         bigint NOT NULL,
    "product_id"          bigint NOT NULL,
    CONSTRAINT "FK_SupplierProduct_SupplierId" FOREIGN KEY ("supplier_id") REFERENCES supplier.supplier ("supplier_id"),
    CONSTRAINT "FK_SupplierProduct_ProductId" FOREIGN KEY ("product_id") REFERENCES product.product ("product_id")
);

CREATE TABLE supplier.supplier_location
(
    "supplier_location_id" bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    "supplier_id" bigint NOT NULL,
    "location_info_id" bigint NOT NULL,
    CONSTRAINT "FK_SupplierLocation_SupplierId" FOREIGN KEY ("supplier_id") REFERENCES supplier.supplier ("supplier_id"),
    CONSTRAINT "FK_SupplierLocation_LocationInfoId" FOREIGN KEY ("location_info_id") REFERENCES company.location_info ("location_info_id")
);

CREATE TABLE supplier.supplier_product_price
(
    "supplier_product_price_id" bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    "start_date" date NOT NULL,
    "price" real NOT NULL,
    "supplier_product_id" bigint NOT NULL,
    CONSTRAINT "FK_SupplierProductPrice_SupplierProductId" FOREIGN KEY ("supplier_product_id") REFERENCES supplier.supplier_product ("supplier_product_id")
);

CREATE TABLE customer.customer_sub_order
(
    "customer_sub_order_id" bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    "amount" real NOT NULL,
    "supplier_product_price_id" bigint NOT NULL,
    CONSTRAINT "FK_CustomerSubOrder_SupplierProductPriceId" FOREIGN KEY ("supplier_product_price_id") REFERENCES supplier.supplier_product_price ("supplier_product_price_id")
);

CREATE TABLE customer.customer_order_detail
(
    "customer_order_detail_id" bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    "customer_order_id" bigint NOT NULL,
    "customer_sub_order_id" bigint NOT NULL,
    CONSTRAINT "FK_CustomerOrderDetail_CustomerOrderId" FOREIGN KEY ("customer_order_id") REFERENCES customer.customer_order ("customer_order_id"),
    CONSTRAINT "FK_CustomerOrderDetail_CustomerSubOrderId" FOREIGN KEY ("customer_sub_order_id") REFERENCES customer.customer_sub_order ("customer_sub_order_id")
);

CREATE TABLE supplier.supplier_product_margin
(
    "supplier_product_margin_id" bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    "margin"                     real   NOT NULL,
    "supplier_product_id"        bigint NOT NULL,
    CONSTRAINT "FK_SupplierProductMargin_SupplierProductId" FOREIGN KEY ("supplier_product_id") REFERENCES supplier.supplier_product ("supplier_product_id")
);

CREATE TABLE product.product_discount
(
    "product_discount_id" bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    "discount"            real   NOT NULL,
    "start_date"          date   NOT NULL,
    "finish_date"         date   NOT NULL,
    "supplier_product_id" bigint NOT NULL,
    CONSTRAINT "FK_ProductDiscount_SupplierProductId" FOREIGN KEY ("supplier_product_id") REFERENCES supplier.supplier_product ("supplier_product_id"),
    CONSTRAINT "ProductDiscount_CheckDiscount" CHECK ( discount > 0 AND discount < 1 AND start_date < finish_date )
);

CREATE TABLE product.category_discount
(
    "category_discount_id" bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    "discount"             real   NOT NULL,
    "start_date"           date   NOT NULL,
    "finish_date"          date   NOT NULL,
    "category_id"          bigint NOT NULL,
    CONSTRAINT "FK_ProductCategoryDiscount_SupplierProductId" FOREIGN KEY ("category_id") REFERENCES product.category ("category_id"),
    CONSTRAINT "CategoryDiscount_CheckDiscount" CHECK ( discount > 0 AND discount < 1 AND start_date < finish_date )
);

CREATE TABLE customer.category_customer_discount
(
    "product_category_discount_id" bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    "discount"                     real   NOT NULL,
    "start_date"                   date   NOT NULL,
    "finish_date"                  date   NOT NULL,
    "customer_id"                  bigint NOT NULL,
    "category_id"                  bigint NOT NULL,
    CONSTRAINT "FK_CategoryCustomerDiscount_CustomerId" FOREIGN KEY ("customer_id") REFERENCES customer.customer ("customer_id"),
    CONSTRAINT "FK_CategoryCustomerDiscount_CategoryId" FOREIGN KEY ("category_id") REFERENCES product.category ("category_id"),
    CONSTRAINT "CategoryCustomerDiscount_CheckDiscount" CHECK ( discount > 0 AND discount < 1 AND start_date < finish_date )
);

CREATE TABLE customer.product_customer_discount
(
    "product_customer_discount_id" bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    "discount"                     real   NOT NULL,
    "start_date"                   date   NOT NULL,
    "finish_date"                  date   NOT NULL,
    "customer_id"                  bigint NOT NULL,
    "supplier_product_id"          bigint NOT NULL,
    CONSTRAINT "FK_ProductCustomerDiscount_CustomerId" FOREIGN KEY ("customer_id") REFERENCES customer.customer ("customer_id"),
    CONSTRAINT "FK_ProductCustomerDiscount_CategoryId" FOREIGN KEY ("supplier_product_id") REFERENCES supplier.supplier_product ("supplier_product_id"),
    CONSTRAINT "ProductCustomerDiscount_CheckDiscount" CHECK ( discount > 0 AND discount < 1 AND start_date < finish_date )
);

CREATE TABLE company.warehouse_detail
(
    "warehouse_detail_id" bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    "amount"              real   NOT NULL,
    "supplier_product_id" bigint NOT NULL,
    CONSTRAINT "FK_WareHouseDetail_SupplierProductId" FOREIGN KEY ("supplier_product_id") REFERENCES supplier.supplier_product ("supplier_product_id")
);
