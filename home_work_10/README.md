# Otus internet shop (MySQL)

    ./create_data_model.sql - реализована БД интернет-магазина со следующими изменениями в типах данных:
        - PK изменен с serial на int auto increment
        - timestamp изменен на datetime
    
    Добавлена таблица product_tag с типом json:
        create table product_tag
        (
            product_tag_id int primary key auto_increment,
            product_id     int not null,
            product_tags   json default null,
            constraint FK_ProductTag_ProductId foreign key (product_id) references product (product_id)
        );

    В поле product_tags предлагается указывать тэги продукта, которые расширяли возможности описания и поиска 
    продуктов (помимо категорий).

    Пример записис данных: 
    insert into product_tag (product_id, product_tags) values (
        1, '["ФИТНЕС", "СПОРТИВНОЕ ПИТАНИЕ", "НОВИНКА"]'
    );

    Пример получения данных:
    select product_id from product_tags where json_search(product_tags, '["НОВИНКА"]')