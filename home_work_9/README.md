# MySQL docker setup

Хост-машина на ОС Windows, поэтому для sysbench использовался отдельный контейнер severalnines/sysbench.
В my.cnf выставлено тестовое значение innodb_buffer_pool_size=256M

Выполнение:

    1) cd [PROJECT_ROOT]/home_work_9
    2) docker-compose up
    3) В отдельной консоли переходим в контейнер severalnines/sysbench: docker run --rm=true -it --name=sb-prepare severalnines/sysbench
    4) В отдельной консоли узнаем ИД контейнера sysbench (например cceed41cc3bb) и добавляем его в виртуальную сеть
    сервисов, которую создал docker-compose: docker network connect home_work_9_default cceed41cc3bb
    5) Внутри контейнера severalnines/sysbench выполняем:
        - sysbench --db-driver=mysql --mysql-host=otusdb --mysql-port=3306 --mysql-user=root --mysql-password=12345 --mysql-db=otus_internet_shop /usr/share/sysbench/oltp_read_write.lua prepare
        - sysbench --db-driver=mysql --mysql-host=otusdb --mysql-port=3306 --mysql-user=root --mysql-password=12345 --mysql-db=otus_internet_shop /usr/share/sysbench/oltp_read_write.lua run

Результат тестирования в ./sysbench-result.txt