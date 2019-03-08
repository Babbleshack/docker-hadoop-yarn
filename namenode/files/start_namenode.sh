#!/usr/bin/env bash
#cat /etc/hosts
#echo $HOSTNAME
hostname
rm -rf $HADOOP_DATA_NODE_DATA/*
rm -rf $HADOOP_NAME_NODE_DATA/*
rm -rf $HADOOP_TEMPDIR/*
/etc/init.d/ssh start
$HADOOP_HOME/bin/hdfs namenode -format
$HADOOP_HOME/bin/hdfs namenode 
tail -f $HADDOP_HOME/logs/hadoop-*-namenode-*.log 
