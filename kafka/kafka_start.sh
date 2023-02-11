## create topic
#/Users/jianlin/kafka_2.13-3.4.0/bin/kafka-topics.sh --create --topic news --bootstrap-server localhost:9092


## edit messenger into topic
#/Users/jianlin/kafka_2.13-3.4.0/bin/kafka-console-producer.sh --topic news --bootstrap-server localhost:9092


## read messenger from topic
#/Users/jianlin/kafka_2.13-3.4.0/bin/kafka-console-consumer.sh --topic news --from-beginning --bootstrap-server localhost:9092

