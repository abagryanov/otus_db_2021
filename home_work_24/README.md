# Otus cassandra

Для сравнения выбраны 2 драйвера: Datastax ORM и Kundera
За основу взята работа: https://github.com/hands-on-tech/cassandra-jpa-example

Для работы Kundera необходим порт 9160, который не доступен (Вопрос почему? 
см docker-compose.yml, START_RPC=true)

Для Datastax ORM получены следующие значения:

ru.otus.cassandra.runner.RunDatastax -         WRITE   5       34023   13159   4720    6804.6
ru.otus.cassandra.runner.RunDatastax -         READ    5       35429   12096   5304    7085.8
ru.otus.cassandra.runner.RunDatastax -         UPDATE  5       28094   6161    5134    5618.8
ru.otus.cassandra.runner.RunDatastax -         DELETE  5       25326   5459    4680    5065.2