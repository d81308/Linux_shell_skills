#!/bin/sh

DATABASE=sakila

/usr/local/mysql/bin/mysql -Nse 'show tables' sakila | \
	while read table; do /usr/local/mysql/bin/mysql --host=127.0.0.1 --port=3306 \
	-e "use sakila;SET FOREIGN_KEY_CHECKS=0;truncate table $table;SET FOREIGN_KEY_CHECKS=1;" ;done


