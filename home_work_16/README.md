# Otus internet shop (MySQL). Optimization

Для выполнения ДЗ возьмем БД AdventureWorks, т.к. в проекте малое количество данных.
Рассмотрим запрос из прошлых заданий:

    select max(ListPrice) as max_price,
    min(ListPrice) as min_price,
    count(*) as products_in_category,
    productcategory.Name as category from product
    left join productsubcategory on product.ProductSubcategoryID = productsubcategory.ProductSubcategoryID
    left join productcategory on productsubcategory.ProductCategoryID = productcategory.ProductCategoryID
    where product.ProductSubcategoryID is not null group by category with rollup;

Рассмотрим результат explain в 3-х форматах

    1) Traditional
        id, select_type, table, partitions, type, possible_keys, key, key_len, ref, rows, filtered, Extra
        1	SIMPLE	product		ALL	my_fk_22				504	58.53	Using where; Using temporary; Using filesort
        1	SIMPLE	productsubcategory		eq_ref	PRIMARY	PRIMARY	4	adventureworks.product.ProductSubcategoryID	1	100.00  NULL
        1	SIMPLE	productcategory		eq_ref	PRIMARY	PRIMARY	4	adventureworks.productsubcategory.ProductCategoryID	1	100.00  NULL

    2) Json
            {
        "query_block": {
        "select_id": 1,
        "cost_info": {
        "query_cost": "553.40"
        },
        "grouping_operation": {
        "using_temporary_table": true,
        "using_filesort": true,
        "cost_info": {
        "sort_cost": "295.00"
        },
        "buffer_result": {
        "using_temporary_table": true,
        "nested_loop": [
        {
        "table": {
        "table_name": "product",
        "access_type": "ALL",
        "possible_keys": [
        "my_fk_22"
        ],
        "rows_examined_per_scan": 504,
        "rows_produced_per_join": 294,
        "filtered": "58.53",
        "cost_info": {
        "read_cost": "22.40",
        "eval_cost": "29.50",
        "prefix_cost": "51.90",
        "data_read_per_join": "119K"
        },
        "used_columns": [
        "ProductID",
        "ListPrice",
        "ProductSubcategoryID"
        ],
        "attached_condition": "(`adventureworks`.`product`.`ProductSubcategoryID` is not null)"
        } }, {
        "table": {
        "table_name": "productsubcategory",
        "access_type": "eq_ref",
        "possible_keys": [
        "PRIMARY"
        ],
        "key": "PRIMARY",
        "used_key_parts": [
        "ProductSubcategoryID"
        ],
        "key_length": "4",
        "ref": [
        "adventureworks.product.ProductSubcategoryID"
        ],
        "rows_examined_per_scan": 1,
        "rows_produced_per_join": 294,
        "filtered": "100.00",
        "cost_info": {
        "read_cost": "73.75",
        "eval_cost": "29.50",
        "prefix_cost": "155.15",
        "data_read_per_join": "53K"
        },
        "used_columns": [
        "ProductSubcategoryID",
        "ProductCategoryID"
        ]
        } }, {
        "table": {
        "table_name": "productcategory",
        "access_type": "eq_ref",
        "possible_keys": [
        "PRIMARY"
        ],
        "key": "PRIMARY",
        "used_key_parts": [
        "ProductCategoryID"
        ],
        "key_length": "4",
        "ref": [
        "adventureworks.productsubcategory.ProductCategoryID"
        ],
        "rows_examined_per_scan": 1,
        "rows_produced_per_join": 294,
        "filtered": "100.00",
        "cost_info": {
        "read_cost": "73.75",
        "eval_cost": "29.50",
        "prefix_cost": "258.40",
        "data_read_per_join": "53K"
        },
        "used_columns": [
        "ProductCategoryID",
        "Name"
        ]
        } }
        ]
        } } } }

        3) Tree
            -> Table scan on <temporary>  (cost=2.50..2.50 rows=0) (actual time=0.001..0.001 rows=5 loops=1)
                -> Temporary table  (cost=2.50..2.50 rows=0) (actual time=0.811..0.812 rows=5 loops=1)
                    -> Group aggregate with rollup: max(product.ListPrice), min(product.ListPrice), count(0)  (actual time=0.684..0.798 rows=5 loops=1)
                        -> Sort: productcategory.`Name`  (actual time=0.663..0.681 rows=295 loops=1)
                            -> Stream results  (cost=258.40 rows=295) (actual time=0.157..0.568 rows=295 loops=1)
                                -> Nested loop inner join  (cost=258.40 rows=295) (actual time=0.154..0.492 rows=295 loops=1)
                                    -> Nested loop inner join  (cost=155.15 rows=295) (actual time=0.149..0.398 rows=295 loops=1)
                                        -> Filter: ((product.ProductSubcategoryID is not null) and (product.ProductSubcategoryID is not null))  (cost=51.90 rows=295) (actual time=0.133..0.248 rows=295 loops=1)
                                            -> Table scan on product  (cost=51.90 rows=504) (actual time=0.063..0.215 rows=504 loops=1)
                                        -> Single-row index lookup on productsubcategory using PRIMARY (ProductSubcategoryID=product.ProductSubcategoryID)  (cost=0.25 rows=1) (actual time=0.000..0.000 rows=1 loops=295)
                                    -> Single-row index lookup on productcategory using PRIMARY (ProductCategoryID=productsubcategory.ProductCategoryID)  (cost=0.25 rows=1) (actual time=0.000..0.000 rows=1 loops=295

Анализ:

Из результата explain (format=tree) видно, что самые дорогие операции это join и обработка группировки с сортировкой.
Видно что выполняется полное сканирование таблицы product (все 504 записи), duration: 0.00136675

Перепишем запрос, убрав where и вместо left join используем inner:

select max(ListPrice) as max_price,
min(ListPrice) as min_price,
count(*) as products_in_category,
productcategory.Name as category from product
inner join productsubcategory on product.ProductSubcategoryID = productsubcategory.ProductSubcategoryID
inner join productcategory on productsubcategory.ProductCategoryID = productcategory.ProductCategoryID
group by category with rollup;

При этом получаем duration: 0.00105625, план запроса:
    
    -> Group aggregate with rollup: max(product.ListPrice), min(product.ListPrice), count(0)  (cost=226.19 rows=491) (actual time=0.132..0.434 rows=5 loops=1)
    -> Nested loop inner join  (cost=177.12 rows=491) (actual time=0.053..0.365 rows=295 loops=1)
        -> Nested loop inner join  (cost=5.36 rows=37) (actual time=0.043..0.057 rows=37 loops=1)
            -> Sort: productcategory.`Name`  (cost=0.65 rows=4) (actual time=0.032..0.032 rows=4 loops=1)
                -> Table scan on productcategory  (cost=0.65 rows=4) (actual time=0.018..0.021 rows=4 loops=1)
            -> Covering index lookup on productsubcategory using my_fk_38 (ProductCategoryID=productcategory.ProductCategoryID)  (cost=0.48 rows=9) (actual time=0.004..0.006 rows=9 loops=4)
        -> Index lookup on product using my_fk_22 (ProductSubcategoryID=productsubcategory.ProductSubcategoryID)  (cost=3.35 rows=13) (actual time=0.005..0.008 rows=8 loops=37)
