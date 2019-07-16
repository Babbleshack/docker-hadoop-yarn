#!/usr/bin/env bash
rm -rf $HADOOP_HOME/hdfs/namenode/*
rm -rf $HADOOP_HOME/hdfs/datanode/*
rm -rf $HADOOP_HOME/hadooptmpdata/*
sed -i 's/yarn-master-0.yarn-service.yarn:8030/0.0.0.0:8049/' $HADOOP_CONF_DIR/yarn-site.xml
/etc/init.d/ssh start
while true
do
  tail -f $HADOOP_HOME/logs/*.log 
  sleep 5
done
