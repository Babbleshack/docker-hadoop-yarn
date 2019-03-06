#!/usr/bin/env bash

/etc/init.d/ssh start
$HADOOP_HOME/bin/hdfs datanode
#update to datanode logs
tail -f /dev/null 

