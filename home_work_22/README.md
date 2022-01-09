# Otus internet shop (Mongo utilities).

Шардированный кластер построен на докер-контейнерах. Кластер состоит из трех реплика-сетах. Каждая реплика состоит из 3 
нод и одного арбитра. Конфиг-сервер состоит из 3 нод.

В контейнере mongos выполняем следующие шаги:
mongo --port 27000
sh.addShard("rs1/mongo11:27011,mongo12:27012,mongo13:27013")
sh.addShard("rs2/mongo21:27021,mongo22:27022,mongo23:27023")
sh.addShard("rs3/mongo31:27031,mongo32:27032,mongo33:27033")
use config
db.settings.save({ _id:"chunksize", value: 1})
use bank
for (var i=0; i<210000; i++) { db.tickets.insert({name: "Max ammout of cost tickets", amount: Math.random()*100}) }

После вставки выполняем
sh.status()

--- Sharding Status ---
sharding version: {
"_id" : 1,
"minCompatibleVersion" : 5,
"currentVersion" : 6,
"clusterId" : ObjectId("61d870c9f13f9980015e2d33")
}
shards:
{  "_id" : "rs1",  "host" : "rs1/mongo11:27011,mongo12:27012,mongo13:27013",  "state" : 1 }
{  "_id" : "rs2",  "host" : "rs2/mongo21:27021,mongo22:27022,mongo23:27023",  "state" : 1 }
{  "_id" : "rs3",  "host" : "rs3/mongo31:27031,mongo32:27032,mongo33:27033",  "state" : 1 }
active mongoses:
"4.4.11" : 1
autosplit:
Currently enabled: yes
balancer:
Currently enabled:  yes
Currently running:  no
Failed balancer rounds in last 5 attempts:  0
Migration Results for the last 24 hours:
86 : Success
databases:
{  "_id" : "bank",  "primary" : "rs2",  "partitioned" : false,  "version" : {  "uuid" : UUID("1db80a48-d26e-4723-8b5e-596cb6d0e7d2"),  "lastMod" : 1 } }
{  "_id" : "config",  "primary" : "config",  "partitioned" : true }
config.system.sessions
shard key: { "_id" : 1 }
unique: false
balancing: true
chunks:
rs1     938
rs2     43
rs3     43
too many chunks to print, use verbose if you want to force print

Далее:
db.tickets.createIndex({amount: 1})
db.tickets.stats()
sh.shardCollection("bank.tickets",{amount: 1 })
sh.status()

--- Sharding Status ---
--- Sharding Status ---
sharding version: {
"_id" : 1,
"minCompatibleVersion" : 5,
"currentVersion" : 6,
"clusterId" : ObjectId("61d870c9f13f9980015e2d33")
}
shards:
{  "_id" : "rs1",  "host" : "rs1/mongo11:27011,mongo12:27012,mongo13:27013",  "state" : 1 }
{  "_id" : "rs2",  "host" : "rs2/mongo21:27021,mongo22:27022,mongo23:27023",  "state" : 1 }
{  "_id" : "rs3",  "host" : "rs3/mongo31:27031,mongo32:27032,mongo33:27033",  "state" : 1 }
active mongoses:
"4.4.11" : 1
autosplit:
Currently enabled: yes
balancer:
Currently enabled:  yes
Currently running:  no
Failed balancer rounds in last 5 attempts:  0
Migration Results for the last 24 hours:
106 : Success
databases:
{  "_id" : "bank",  "primary" : "rs2",  "partitioned" : false,  "version" : {  "uuid" : UUID("1db80a48-d26e-4723-8b5e-596cb6d0e7d2"),  "lastMod" : 1 } }
{  "_id" : "config",  "primary" : "config",  "partitioned" : true }
config.system.sessions
shard key: { "_id" : 1 }
unique: false
balancing: true
chunks:
rs1     918
rs2     53
rs3     53
too many chunks to print, use verbose if you want to force print

-----------------------------

Аутентификация

Для примера сделан компоуз-файл docker-compose-auth.yml, в котором настроена аутентификация шардов через файл.
Для работы необходимо чтобы вначале был создан пользователь с административными правами.
Можно поднять кластер без аутентификации, смапить вольюмы, сделать пользователя, потушить кластер, полнять кластер с 
аутентификацией.

-----------------------------
Вопросы:

1) Не получилось автоматизировать добавление шардов, т.к. для клиента mongo требуется запущенный процесс mongod.
