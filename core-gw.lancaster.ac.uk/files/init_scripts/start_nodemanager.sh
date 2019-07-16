#!/usr/bin/env bash
rm -rf $HADOOP_HOME/hdfs/namenode/*
rm -rf $HADOOP_HOME/hdfs/datanode/*
rm -rf $HADOOP_HOME/hadooptmpdata/*
/etc/init.d/ssh start
sed -i 's/yarn-master-0.yarn-service.yarn:8030/0.0.0.0:8049/' $HADOOP_CONF_DIR/yarn-site.xml
$HADOOP_HOME/bin/yarn nodemanager &
while true
do
  tail -f $HADOOP_HOME/logs/*.log 
  sleep 5
done
