# Otus postgtres replication

При решении за основу использовалась работа: https://github.com/2hamed/docker-pg-replication

    Физическая репликация
    ./physical - пример физической репликации, построенной на докер-контейнерах
        ./physical/images - принтскрины терминала master.png (localhost, port: 5432) и replica.png (localhost, port:5433)
    Выполнение: 
        1. cd ./home_work_8/physical
        2. docker-compose up


    Логическая репликация
    ./logical - пример логической репликации, построенной на докер-контейнерах
        /physical/images - принтскрины терминала master.png (localhost, port: 5432) и replica.png (localhost, port:5433)
        В скрипте инициализации в publisher в таблицу tes добавлется 3 записи. При подъеме subscriber в таблице test
        записи отсутсвуют. При добавлении еще 2 записей в test в publisher, subscriber получает эти 2 записи.
    Выполнение: 
        1. cd ./home_work_8/logical
        2. docker-compose up