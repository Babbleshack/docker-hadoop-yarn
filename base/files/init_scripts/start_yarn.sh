#!/usr/bin/env bash
rm -rf $HADOOP_HOME/hdfs/namenode/*
rm -rf $HADOOP_HOME/hdfs/datanode/*
rm -rf $HADOOP_HOME/hadooptmpdata/*
ln --symbolic --force --verbose /opt/hadoop-kuber-conf/slaves opt/hadoop/etc/hadoop/slaves
ln --symbolic --force --verbose /opt/hadoop-kuber-conf/slaves opt/hadoop/etc/hadoop/workers
sed -i 's/<!--YARN-MASTER//' $HADOOP_CONF_DIR/yarn-site.xml
sed -i 's/YARN-MASTER-->//' $HADOOP_CONF_DIR/yarn-site.xml
/etc/init.d/ssh start
$HADOOP_HOME/sbin/start-yarn.sh
$HADOOP_HOME/sbin/mr-jobhistory-daemon.sh start historyserver &
while true
do
	tail -f $HADOOP_HOME/logs/*.log
  sleep 5
done
