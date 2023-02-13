## read messenger from topic
#/Users/jianlin/kafka_2.13-3.4.0/bin/kafka-console-consumer.sh --topic news --from-beginning --bootstrap-server localhost:9092

file="/Users/jianlin/kafka_2.13-3.4.0/bin/kafka-console-consumer.sh"
server="--bootstrap-server localhost:9092"

#-----------------------------------------------------
## variable cell
topic=$1
mode=$2
group=$3

#-----------------------------------------------------

if [ $mode == 'single' ]; then
	$file --topic $topic --from-beginning $server
elif [ $mode == 'property' ]; then
	$file $server --topic $topic --from-beginning --property print.key=true --property key.separaator=:
elif [ $mode == 'group' ]; then
	$file $server --topic $topic --group $group
fi