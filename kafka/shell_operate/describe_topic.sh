file="/Users/jianlin/kafka_2.13-3.4.0/bin/kafka-topics.sh"
topic=$1
server="--bootstrap-server localhost:9092"

$file $server --describe --topic $topic