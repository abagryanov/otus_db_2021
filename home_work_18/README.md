# Otus internet shop. XtraBackup

Сделано решение в контейнере. Для того чтобы можно было использовать восстановленные данные в образ монтируются
2 директории. Логика восстановления данных находится в скрипте ./backup/restore_schema.sh
В /tmp/backup/stream2 выполняется копирование данных: 
xtrabackup --copy-back --target-dir=/tmp/backup/stream --datadir=/tmp/backup/stream2
/tmp/backup/stream2 - смаплен в папку хост-машины.
Далее контейнер останавливается, копируется файл city.ibd.
После поднятия контейнера, обновляются тейблспейс таблицы city:
alter table city discard tablespace;
alter table city import tablespace;

Запрос select count(*) from city where countrycode = 'RUS';
Возвращает 189.