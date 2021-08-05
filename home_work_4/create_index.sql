-- Table customer.customer_order
create index customer_order_customer_id_idx on customer.customer_order (customer_id);
create index customer_order_customer_order_status_id_idx on customer.customer_order (customer_order_status_id);

-- Table company.pickup_delivery_location
create index pickup_delivery_location_location_info_id_idx on company.pickup_delivery_location (location_info_id);

-- Table customer.customer_delivery_location
create index customer_delivery_location_customer_id_idx on customer.customer_delivery_location (customer_id);
create index customer_delivery_location_location_info_id_idx on customer.customer_delivery_location (location_info_id);

-- Table customer.customer_order_delivery
create index customer_order_delivery_customer_order_id_idx on customer.customer_order_delivery (customer_order_id);
create index customer_order_delivery_delivery_type_id_idx on customer.customer_order_delivery (delivery_type_id);
create index customer_order_delivery_pickup_delivery_location_id_idx on customer.customer_order_delivery (pickup_delivery_location_id);
create index customer_order_delivery_customer_delivery_location_id_idx on customer.customer_order_delivery (customer_delivery_location_id);

-- Table product.product
create index product_product_sale_type_id_idx on product.product (product_sale_type_id);
create index product_name_idx on product.product (name);
create index product_article_idx on product.product (article);

-- Table product.product_margin
create index product_margin_product_id_idx on product.product_margin (product_id);

-- Table product.product_category
create index product_category_product_id_idx on product.product_category (product_id);
create index product_category_category_id_idx on product.product_category (category_id);

-- Table supplier.supplier_product
create index supplier_product_supplier_id_idx on supplier.supplier_product(supplier_id);
create index supplier_product_product_id_idx on supplier.supplier_product(product_id);

-- Table supplier.supplier_location
create index supplier_location_supplier_id_idx on supplier.supplier_location(supplier_id);
create index supplier_location_location_info_id_idx on supplier.supplier_location(location_info_id);

-- Table supplier.supplier_product_price
create index supplier_product_price_supplier_product_id_idx on supplier.supplier_product_price(supplier_product_id);

-- Table customer.customer_sub_order
create index customer_sub_order_supplier_product_price_id_idx on customer.customer_sub_order(supplier_product_price_id);

-- Table customer.customer_order_detail
create index customer_order_detail_customer_order_id_idx on customer.customer_order_detail(customer_order_id);
create index customer_order_detail_customer_sub_order_id_idx on customer.customer_order_detail(customer_sub_order_id);

-- Table supplier.supplier_product_margin
create index product_discount_supplier_product_id_idx on product.product_discount(supplier_product_id);

-- Table product.product_discount
create index category_discount_category_id_idx on product.category_discount(category_id);

-- Table customer.category_customer_discount
create index category_customer_discount_customer_id_idx on customer.category_customer_discount(customer_id);
create index category_customer_discount_category_id_idx on customer.category_customer_discount(category_id);

-- Table customer.product_customer_discount
create index product_customer_discount_customer_id_idx on customer.product_customer_discount(customer_id);
create index product_customer_discount_supplier_product_id_idx on customer.product_customer_discount(supplier_product_id);

-- Table company.warehouse_detail
create index warehouse_detail_supplier_product_id_idx on company.warehouse_detail(supplier_product_id);