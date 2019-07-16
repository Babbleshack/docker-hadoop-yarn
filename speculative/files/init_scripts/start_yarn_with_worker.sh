#!/usr/bin/env bash
#ln -sfv /opt/hadoop-kuber-conf/slaves $HADOOP_HOME/etc/hadoop/slaves
ln --symbolic --force --verbose /opt/hadoop-kuber-conf/slaves $HADOOP_HOME/etc/hadoop/slaves
rm -rf $HADOOP_HOME/hdfs/namenode/*
rm -rf $HADOOP_HOME/hdfs/datanode/*
rm -rf $HADOOP_HOME/hadooptmpdata/*
/etc/init.d/ssh start
$HADOOP_HOME/sbin/start-yarn.sh
$HADOOP_HOME/sbin/mr-jobhistory-daemon.sh start historyserver
while true
do
	tail -f $HADOOP_HOME/logs/*.log
  sleep 5
done
