delimiter $$

create procedure create_customer_order(in user_id int, in order_products json, in is_customer_delivery_location boolean,
                                in delivery_location_id int, in delivery_date date, in delivery_info text,
                                out customer_order_delivery_id int)
begin
    declare order_products_counter int unsigned
        default 0;
    declare order_products_size int unsigned
        default json_length(order_products);
    declare total_price numeric unsigned
        default 0;
    declare total_discount numeric unsigned
        default 0;
    declare exit handler for sqlexception
        begin
            rollback;
        end;
    start transaction;
        if (isnull(user_id) = 1) then
            signal sqlstate '45001' set message_text = 'Invalid parameter: user_id should not be null';
        elseif (isnull(delivery_location_id) = 1) then
            signal sqlstate '45001' set message_text = 'Invalid parameter: customer_delivery_location_id should not be null';
        end if;

        insert into otus_internet_shop.customer_order(created_datetime, customer_id, customer_order_status_id)
            values (now(), user_id, 1);
        set @customer_order_id = last_insert_id();

        repeat
            set @product_item = json_extract(order_products, concat('$[', order_products_counter, ']'));
            set @supplier_product_id = json_extract(@product_item, '$.supplier_product_id');
            select product_id into @product_id from otus_internet_shop.supplier_product where
                    supplier_product_id = @supplier_product_id;
            set @product_amount = json_extract(@product_item, '$.amount');
            select max(discount) into @product_discount from otus_internet_shop.product_discount where
                supplier_product_id = @supplier_product_id and
                start_date <= now() and
                finish_date >= now();
            select max(discount) into @category_discount from otus_internet_shop.category_discount where
                category_id in (select category_id from otus_internet_shop.product_category where
                    product_id = @product_id) and
                start_date <= now() and
                finish_date >= now();
            select max(discount) into @product_customer_discount from otus_internet_shop.product_customer_discount where
                customer_id = user_id and
                supplier_product_id = @supplier_product_id and
                start_date <= now() and
                finish_date >= now();
            select max(discount) into @category_customer_discount from otus_internet_shop.category_customer_discount where
                category_id in (select category_id from otus_internet_shop.product_category where
                    product_id = @product_id) and
                start_date <= now() and
                finish_date >= now();
            set @product_final_discount = greatest(@product_discount, @category_discount, @product_customer_discount,
                @category_customer_discount);
            select supplier_product_price_id, price into @supplier_product_price_id, @product_price from
                otus_internet_shop.supplier_product_price where
                price = (select max(price) from otus_internet_shop.supplier_product_price where
                    supplier_product_id = @supplier_product_id) and
                supplier_product_id = @supplier_product_id and
                start_date <= now();
            select margin into @product_margin from otus_internet_shop.product_margin where
                margin = (select max(margin) from otus_internet_shop.product_margin where
                        product_id = @product_id) and
                product_id = @product_id;
            set total_price = total_price + (1 - @product_discount) * @product_margin * @product_price * @product_amount;
            set total_discount = total_discount + @product_discount * @product_margin * @product_price * @product_amount;
            update otus_internet_shop.customer_order set
                total_price = total_price,
                total_discount = total_discount
            where customer_order_id = @customer_order_id;
            insert into otus_internet_shop.customer_sub_order(amount, supplier_product_price_id) values
                (@product_amount, @supplier_product_price_id);
            set @customer_sub_order_id = last_insert_id();
            insert into otus_internet_shop.customer_order_detail(customer_order_id, customer_sub_order_id) values
                (@customer_order_id, @customer_sub_order_id);
            set order_products_counter = order_products_counter + 1;
        until order_products_counter = order_products_size
        end repeat ;
    if (is_customer_delivery_location) then
        insert into otus_internet_shop.customer_order_delivery(delivery_date, delivery_info, customer_order_id,
                                                               delivery_type_id, customer_delivery_location_id) values
        (delivery_date, delivery_info, @customer_order_id, 2, delivery_location_id);
    else
        insert into otus_internet_shop.customer_order_delivery(delivery_date, delivery_info, customer_order_id,
                                                               delivery_type_id, pickup_delivery_location_id) values
        (delivery_date, delivery_info, @customer_order_id, 1, delivery_location_id);
    end if;
    commit;
    set customer_order_delivery_id = last_insert_id();

end $$
delimiter ;