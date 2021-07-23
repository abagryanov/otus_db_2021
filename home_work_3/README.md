#Postgres installation

 1. Установка внутри Docker

    Для развертывания postgres внутри Docker делаем следующие шаги в терминале:
        
    * cd home_work3
    * docker-compose up
    
    Проверка подключения выполняется следующим образом:
    
    * Переходим в браузере по Url: http://localhost:8080
    * В Adminer вводим данные:
    
        - Движок: PostgreSQL
        - Сервер: postgres
        - Имя пользователя: root
        - Пароль: root123
        - База данных: postgres
    
 2. Произведена локальная установка Postgres на ОС Windows для дальнейшей работы, отработки навыков.
    * Подключение через консоль (postgres_connect_shell.png)
    * Подключение через PgAdmin (postgres_connect_pgAdmin.png)