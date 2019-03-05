#!/usr/bin/env bash

/etc/init.d/ssh start
$HADOOP_HOME/bin/hdfs namenode -format 
$HADOOP_HOME/sbin/start-dfs.sh 
#ps axf | grep proc_namenode | grep -v grep | awk '{print "wait " $1}'
tail -f $HADOOP_HOME/logs/hadoop-root-namenode-*.log

