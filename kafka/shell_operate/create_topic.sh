## create topic
#/Users/jianlin/kafka_2.13-3.4.0/bin/kafka-topics.sh --create --topic <your-topic> --bootstrap-server localhost:9092
#/Users/jianlin/kafka_2.13-3.4.0/bin/kafka-topics.sh --bootstrap-server localhost:9092 --create --topic <your-topic>  --partitions 2

file="/Users/jianlin/kafka_2.13-3.4.0/bin/kafka-topics.sh"
topic=$1
server="--bootstrap-server localhost:9092"

$file --create --topic $topic $server