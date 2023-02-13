## edit messenger into topic
#/Users/jianlin/kafka_2.13-3.4.0/bin/kafka-console-producer.sh --topic news --bootstrap-server localhost:9092

file="/Users/jianlin/kafka_2.13-3.4.0/bin/kafka-console-producer.sh"
topic=$1
server="--bootstrap-server localhost:9092"

if [ $2 == 'single' ]; then
	$file --topic $topic $server
elif [ $2 == 'property' ]; then
	$file $server --topic $topic --property parse.key=true --property key.separator=:
fi
