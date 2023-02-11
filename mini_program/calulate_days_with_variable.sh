cur=$(date "+%Y-%m-%d")
echo $cur

num_cur=$(date --date="$cur" '+%s')
echo $num_cur

num_t_cur=$(($num_cur + 24 * 60 * 60))
echo $num_t_cur

t_cur=$(date --date=@"$num_t_cur" "+%Y-%m-%d")
echo $t_cur
