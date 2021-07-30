-- Table customer.customer_order
CREATE INDEX customer_order_customer_id_idx ON customer.customer_order (customer_id);
CREATE INDEX customer_order_customer_order_status_id_idx ON customer.customer_order (customer_order_status_id);

-- Table company.pickup_delivery_location
CREATE INDEX pickup_delivery_location_location_info_id_idx ON company.pickup_delivery_location (location_info_id);

-- Table customer.customer_delivery_location
CREATE INDEX customer_delivery_location_customer_id_idx ON customer.customer_delivery_location (customer_id);
CREATE INDEX customer_delivery_location_location_info_id_idx ON customer.customer_delivery_location (location_info_id);

-- Table customer.customer_order_delivery
CREATE INDEX customer_order_delivery_customer_order_id_idx ON customer.customer_order_delivery (customer_order_id);
CREATE INDEX customer_order_delivery_delivery_type_id_idx ON customer.customer_order_delivery (delivery_type_id);
CREATE INDEX customer_order_delivery_pickup_delivery_location_id_idx ON customer.customer_order_delivery (pickup_delivery_location_id);
CREATE INDEX customer_order_delivery_customer_delivery_location_id_idx ON customer.customer_order_delivery (customer_delivery_location_id);

-- Table product.product
CREATE INDEX product_product_sale_type_id_idx ON product.product (product_sale_type_id);
CREATE INDEX product_name_idx ON product.product (name);
CREATE INDEX product_article_idx ON product.product (article);

-- Table product.product_margin
CREATE INDEX product_margin_product_id_idx ON product.product_margin (product_id);

-- Table product.product_category
CREATE INDEX product_category_product_id_idx ON product.product_category (product_id);
CREATE INDEX product_category_category_id_idx ON product.product_category (category_id);

-- Table supplier.supplier_product
CREATE INDEX supplier_product_supplier_id_idx ON supplier.supplier_product(supplier_id);
CREATE INDEX supplier_product_product_id_idx ON supplier.supplier_product(product_id);

-- Table supplier.supplier_location
CREATE INDEX supplier_location_supplier_id_idx ON supplier.supplier_location(supplier_id);
CREATE INDEX supplier_location_location_info_id_idx ON supplier.supplier_location(location_info_id);

-- Table supplier.supplier_product_price
CREATE INDEX supplier_product_price_supplier_product_id_idx ON supplier.supplier_product_price(supplier_product_id);

-- Table customer.customer_sub_order
CREATE INDEX customer_sub_order_supplier_product_price_id_idx ON customer.customer_sub_order(supplier_product_price_id);

-- Table customer.customer_order_detail
CREATE INDEX customer_order_detail_customer_order_id_idx ON customer.customer_order_detail(customer_order_id);
CREATE INDEX customer_order_detail_customer_sub_order_id_idx ON customer.customer_order_detail(customer_sub_order_id);

-- Table supplier.supplier_product_margin
CREATE INDEX product_discount_supplier_product_id_idx ON product.product_discount(supplier_product_id);

-- Table product.product_discount
CREATE INDEX category_discount_category_id_idx ON product.category_discount(category_id);

-- Table customer.category_customer_discount
CREATE INDEX category_customer_discount_customer_id_idx ON customer.category_customer_discount(customer_id);
CREATE INDEX category_customer_discount_category_id_idx ON customer.category_customer_discount(category_id);

-- Table customer.product_customer_discount
CREATE INDEX product_customer_discount_customer_id_idx ON customer.product_customer_discount(customer_id);
CREATE INDEX product_customer_discount_supplier_product_id_idx ON customer.product_customer_discount(supplier_product_id);

-- Table company.warehouse_detail
CREATE INDEX warehouse_detail_supplier_product_id_idx ON company.warehouse_detail(supplier_product_id);