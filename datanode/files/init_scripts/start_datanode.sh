#!/usr/bin/env bash


rm -rf $HADOOP_DATA_NODE_DATA/*
rm -rf $HADOOP_NAME_NODE_DATA/*
rm -rf $HADOOP_TEMPDIR/*
/etc/init.d/ssh start
$HADOOP_HOME/bin/hdfs datanode
#$HADOOP_HOME/bin/hdfs --daemon start datanode
#$HADOOP_HOME/sbin/hadoop-daemon.sh start datanode
#tail -f $HADOOP_HOME/logs/hadoop-*-datanode-*.log
#update to datanode logs
#tail -f /dev/null 

