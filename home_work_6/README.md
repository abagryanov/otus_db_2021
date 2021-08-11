# Internet shop 6

Индексы к БД созданы в файле home_work_4/create_index.sql

1) На таблице product.product созданы два простых индекса на поля name и article
    - Запрос: explain select article from product.product where name = 'ЯБЛОКИ АНТОНОВКА';
    - Ответ:    "Index Scan using product_name_idx on product  (cost=0.15..8.17 rows=1 width=118)"
                "  Index Cond: ((name)::text = 'ЯБЛОКИ АНТОНОВКА'::text)"
      
   - При повторных запросах может выполняться через Sequence scan (странно)
      
2) Реализовать индекс для полнотекстового поиска
    - В таблице product.product есть поле description типа text. Создадим индекс для полнотекстового поиска:
      create index product_description_idx on product.product using gin(to_tsvector('russian'::regconfig, description));
      
    - Выполним запрос:
      explain (analyze, costs off)
      select * from product.product where to_tsvector(description) @@ to_tsquery('COCA');
      
   - Ответ (несмотря на наличие индекса):
     "Seq Scan on product (actual time=0.182..0.595 rows=1 loops=1)"
     "  Filter: (to_tsvector(description) @@ to_tsquery('COCA'::text))"
     "  Rows Removed by Filter: 8"
     "Planning Time: 0.250 ms"
     "Execution Time: 0.621 ms"
     
3) Реализовать индекс на часть таблицы или индекс на поле с функцией
   Для таблицы customer.customer_order создадим индекс всех оплаченных счетов:

   create index customer_order_payed_idx on customer.customer_order (payed_timestamp) 
   where not (payed_timestamp is null);
   
4) Создать индекс на несколько полей
   Можно усовершенствовать предыдущий индекс и хранить в нем не только дату платежа но и итоговую сумму заказа 
   с вычетом скидки:
   create index customer_order_payed_idx on customer.customer_order (payed_timestamp, (total_price - total_discount)) 
   where not (payed_timestamp is null);