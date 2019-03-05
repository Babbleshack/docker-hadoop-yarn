#!/usr/bin/env bash

/etc/init.d/ssh start
$HADOOP_HOME/bin/hdfs namenode -format
$HADOOP_HOME/bin/hdfs namenode 

