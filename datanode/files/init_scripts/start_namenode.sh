#!/usr/bin/env bash
/etc/init.d/ssh start
$HADOOP_HOME/bin/hdfs namenode -format
$HADOOP_HOME/bin/hdfs --daemon start namenode
$HADOOP_HOME/bin/hdfs --daemon start secondarynamenode
tail -f $HADOOP_HOME/logs/hadoop-*-secondarynamenode-*.log & tail -f $HADOOP_HOME/logs/hadoop-*-namenode-*.log
