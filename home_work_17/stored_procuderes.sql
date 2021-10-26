use otus_internet_shop;

delimiter $$

# Возвращает цену на товар поставщика с учетом скидок.
# productId - идентификатор товара
# supplierProductId - идентификатор товара в разрезе поставщика
# customerId - идентификатор покупателя
create function get_customer_price(productId int, supplierProductId int, customerId int)
    returns numeric(10, 2)
    deterministic
begin
    select max(discount)
    into @productDiscount
    from otus_internet_shop.product_discount
    where supplier_product_id = supplierProductId
      and start_date <= now()
      and finish_date >= now();

    select max(discount)
    into @categoryDiscount
    from otus_internet_shop.category_discount
    where category_id in (select category_id
                          from otus_internet_shop.product_category
                          where product_id = productId)
      and start_date <= now()
      and finish_date >= now();

    select max(discount)
    into @productCustomerDiscount
    from otus_internet_shop.product_customer_discount
    where customer_id = customerId
      and supplier_product_id = supplierProductId
      and start_date <= now()
      and finish_date >= now();

    select max(discount)
    into @categoryCustomerDiscount
    from otus_internet_shop.category_customer_discount
    where category_id in (select category_id
                          from otus_internet_shop.product_category
                          where product_id = productId)
      and customer_id = customerId
      and start_date <= now()
      and finish_date >= now();

    set @productFinalDiscount = greatest(@productDiscount, @categoryDiscount, @productCustomerDiscount,
                                         @categoryCustomerDiscount);
    if (@productFinalDiscount is null) then
        set @productFinalDiscount = 0;
    end if;

    select price
    into @productPrice
    from otus_internet_shop.supplier_product_price
    where price = (select max(price)
                   from otus_internet_shop.supplier_product_price
                   where supplier_product_id = supplierProductId)
      and supplier_product_id = supplierProductId
      and start_date <= now();

    select margin
    into @productMargin
    from otus_internet_shop.product_margin
    where margin = (select max(margin)
                    from otus_internet_shop.product_margin
                    where product_id = productId)
      and product_id = productId;

    return (1 - @productFinalDiscount) * @productMargin * @productPrice;
end $$

# Возвращает список товаров по следующим фильтрам:
# categories - список категорий товаров. Пример: '["category1", "category2"]'
# priceFrom - нижняя граница закупочной цены
# priceTo - верхняя граница закупочной цены
# suppliers - список поставщиков товаров. Пример: '["supplier1", "supplier2"]'
# additionalFilters - дополнительные фильтры в виде where expression. Пример: '["whereExpression1", "whereExpression2"]'
# '["whereExpression1", "whereExpression2"]' => whereExpression1 and whereExpression2
# sortField - поле для сортировки
# customerId - идентификатор пользователя для расчета цены с учетом скидок
create procedure select_products(in categories json, in priceFrom numeric(10, 2), in priceTo numeric(10, 2),
                                 in suppliers json, in additionalFilters json, in sortField varchar(100),
                                 in customerId int)
begin
    set @filterDelimiter = ',';
    set @additionalFilterDelimiter = ' and ';
    set @categoriesCounter = 0;
    set @categoriesLength = json_length(categories);
    set @categoriesFilter = '';
    set @suppliersCounter = 0;
    set @suppliersLength = json_length(suppliers);
    set @suppliersFilter = '';
    set @additionalFiltersCounter = 0;
    set @additionalFiltersLength = json_length(additionalFilters);
    set @additionalFiltersFilter = '';
    set @whereExpression = '';

    if (@categoriesLength > 0) then
        repeat
            if (length(@categoriesFilter) > 0) then
                set @categoriesFilter = concat(@categoriesFilter, @filterDelimiter);
            end if;
            set @categoriesFilter = concat(@categoriesFilter,
                                           json_extract(categories, concat('$[', @categoriesCounter, ']')));
            set @categoriesCounter = @categoriesCounter + 1;
        until @categoriesCounter = @categoriesLength
            end repeat;
        if (length(@categoriesFilter) > 0) then
            set @categoriesFilter = concat('category.name in (', @categoriesFilter, ')');
        end if;
    end if;

    if (@suppliersLength > 0) then
        repeat
            if (length(@suppliersFilter) > 0) then
                set @suppliersFilter = concat(@suppliersFilter, @filterDelimiter);
            end if;
            set @suppliersFilter = concat(@suppliersFilter,
                                          json_extract(suppliers, concat('$[', @suppliersCounter, ']')));
            set @suppliersCounter = @suppliersCounter + 1;
        until @suppliersCounter = @suppliersLength
            end repeat;
        if (length(@suppliersFilter) > 0) then
            set @suppliersFilter = concat('supplier.name in (', @suppliersFilter, ')');
        end if;
    end if;

    if (@additionalFiltersLength > 0) then
        repeat
            if (length(@additionalFiltersFilter) > 0) then
                set @additionalFiltersFilter = concat(@additionalFiltersFilter, @additionalFilterDelimiter);
            end if;
            set @additionalFilterItem = json_extract(additionalFilters, concat('$[', @additionalFiltersCounter, ']'));
            set @additionalFilterItem = substr(@additionalFilterItem, 2, length(@additionalFilterItem) - 2);
            set @additionalFiltersFilter = concat(@additionalFiltersFilter, @additionalFilterItem);
            set @additionalFiltersCounter = @additionalFiltersCounter + 1;
        until @additionalFiltersCounter = @additionalFiltersLength
            end repeat;
    end if;

    if (length(@categoriesFilter) > 0) then
        set @whereExpression = @categoriesFilter;
    end if;

    if (priceFrom > 0) then
        if (length(@whereExpression) > 0) then
            set @whereExpression = concat(@whereExpression, ' and ', 'supplier_product_price.price > ', priceFrom);
        else
            set @whereExpression = concat('supplier_product_price.price >= ', priceFrom);
        end if;
    end if;

    if (priceTo > 0) then
        if (length(@whereExpression) > 0) then
            set @whereExpression = concat(@whereExpression, ' and ', 'supplier_product_price.price < ', priceTo);
        else
            set @whereExpression = concat('supplier_product_price.price <= ', priceTo);
        end if;
    end if;

    if (length(@suppliersFilter) > 0) then
        if (length(@whereExpression) > 0) then
            set @whereExpression = concat(@whereExpression, ' and ', @suppliersFilter);
        else
            set @whereExpression = @suppliersFilter;
        end if;
    end if;

    if (length(@additionalFiltersFilter) > 0) then
        if (length(@whereExpression) > 0) then
            set @whereExpression = concat(@whereExpression, ' and ', @additionalFiltersFilter);
        else
            set @whereExpression = @additionalFiltersFilter;
        end if;
    end if;

    if (length(sortField) > 0) then
        if (length(@whereExpression) > 0) then
            set @whereExpression = concat(@whereExpression, ' order by ', sortField);
        else
            set @whereExpression = concat('order by ', sortField);
        end if;
    end if;

    set @query = concat('
    select product.article                   as product_article,
           product.name                      as product_name,
           get_customer_price(product.product_id,
                supplier_product.supplier_product_id,',
                        customerId, ')                  as product_price,
           supplier.name                     as supplier,
           category.name                     as category_name
    from otus_internet_shop.product
             inner join supplier_product on (product.product_id = supplier_product.product_id)
             inner join supplier on (supplier_product.supplier_id = supplier.supplier_id)
             inner join product_category on (product.product_id = product_category.product_id)
             inner join category on (product_category.category_id = category.category_id)
             inner join supplier_product_price
                        on (supplier_product.supplier_product_id = supplier_product_price.supplier_product_id)
    where ', @whereExpression, ';');
    prepare statement from @query;
    execute statement;
    deallocate prepare statement;
end
$$

# Возвращает список количества товаров ,проданных за указанный период
# Если поле для группировки не пустое, то возвращается сгруппированные данные по данному ключу с суммой количеств
# по группировке.
# period - период выборки ('HOUR', 'DAY', 'WEEK', 'MONTH', 'YEAR')
# groupingKey - поле для группировки. Например: 'product.name' или 'supplier.name'
create procedure get_orders(in period varchar(10), in groupingKey varchar(50))
begin
    if not period in ('HOUR', 'DAY', 'WEEK', 'MONTH', 'YEAR') then
        signal sqlstate '45001' set message_text =
                'Invalid period parameter. Should be one of (HOUR, DAY, WEEK, MONTH, YEAR)';
    end if;
    set @query = '';
    if (length(groupingKey) > 0) then
        set @query = concat('select sum(amount) as sum_amount, ', groupingKey);
    else
        set @query = 'select amount';
    end if;
    set @query = concat(@query,
                        ' from otus_internet_shop.customer_order_detail
                        inner join customer_order on (customer_order_detail.customer_order_id = customer_order.customer_order_id)
                        inner join customer_sub_order on (customer_order_detail.customer_sub_order_id = customer_sub_order.customer_sub_order_id)
                        inner join supplier_product_price on (customer_sub_order.supplier_product_price_id = supplier_product_price.supplier_product_price_id)
                        inner join supplier_product on (supplier_product_price.supplier_product_id = supplier_product.supplier_product_id)
                        inner join supplier on (supplier_product.supplier_id = supplier.supplier_id)
                        inner join product on (supplier_product.product_id = product.product_id)
                        inner join product_category on (product.product_id = product_category.product_id)
                        inner join category on (product_category.category_id = category.category_id)');
    set @whereExpression = '';
    if (period = 'HOUR') then
        set @whereExpression = ' where timestampdiff(MINUTE, payed_datetime, now()) <= 60';
    elseif (period = 'DAY') then
        set @whereExpression = ' where timestampdiff(HOUR, payed_datetime, now()) <= 24';
    elseif (period = 'WEEK') then
        set @whereExpression = ' where timestampdiff(DAY, payed_datetime, now()) <= 7';
    elseif (period = 'MONTH') then
        set @whereExpression = ' where timestampdiff(MONTH, payed_datetime, now()) <= 1';
    elseif (period = 'YEAR') then
        set @whereExpression = ' where timestampdiff(YEAR, payed_datetime, now()) <= 1';
    end if;
    set @query = concat(@query, @whereExpression);
    if (length(groupingKey) > 0) then
        set @query = concat(@query, ' group by ', groupingKey, ';');
    else
        set @query = concat(@query, ';');
    end if;
    prepare statement from @query;
    execute statement;
    deallocate prepare statement;
end $$
delimiter ;

create user 'client'@'%' identified by 'client';
grant execute on procedure select_products to 'client'@'%';
create user 'manager'@'%' identified by 'manager';
grant execute on procedure get_orders to 'manager'@'%';