## read messenger from topic
#/Users/jianlin/kafka_2.13-3.4.0/bin/kafka-console-consumer.sh --topic news --from-beginning --bootstrap-server localhost:9092

file="/Users/jianlin/kafka_2.13-3.4.0/bin/kafka-consumer-groups.sh"
server="--bootstrap-server localhost:9092"

#-----------------------------------------------------
## variable cell
topic=$1
mode=$2
group=$3

#-----------------------------------------------------

if [ $mode == 'describe' ]; then
	$file $server --describe --group $group
elif [ $mode == 'reset' ]; then
	$file $server --topic $topic --group $group --reset-offsets --to-earliest --execute
elif [ $mode == 'shift' ]; then
	$file $server --topic $topic --group $group --reset-offsets --shift-by -2 --execute
fi
