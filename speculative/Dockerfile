FROM ubuntu:latest

MAINTAINER Babbleshack <dcrl94@gmail.com> Version: 0.1

ARG HADOOP_VERSION=2.9.2
ARG CLUSTER_NAME=hadoop-cluster


ENV ENTRYPOINT_SCRIPT_DIR=/opt/init_container.d

ENV HADOOP_HOME=/opt/hadoop
ENV HADOOP_INSTALL=$HADOOP_HOME
ENV HADOOP_MAPRED_HOME=$HADOOP_HOME
ENV HADOOP_COMMON_HOME=$HADOOP_HOME
ENV HADOOP_HDFS_HOME=$HADOOP_HOME
ENV YARN_HOME=$HADOOP_HOME
ENV HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native
ENV PATH=$PATH:$HADOOP_HOME/sbin:$HADOOP_HOME/bin
ENV HADOOP_OPTS="-Djava.library.path=$HADOOP_HOME/lib/native"
ENV HADOOP_CONF_DIR=${HADOOP_HOME}/etc/hadoop 
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64

ENV HADOOP_DATA_NODE_DATA=${HADOOP_HOME}/hdfs/datanode
ENV HADOOP_NAME_NODE_DATA=${HADOOP_HOME}/hdfs/namenode
ENV HADOOP_TEMPDIR=${HADOOP_HOME}/hadooptmpdata

ENV HDFS_NAMENODE_USER="root"
ENV HDFS_DATANODE_USER="root"
ENV HDFS_SECONDARYNAMENODE_USER="root"
ENV YARN_RESOURCEMANAGER_USER="root"
ENV YARN_NODEMANAGER_USER="root"
ENV YARN_EXAMPLES=${HADOOP_HOME}/share/hadoop/mapreduce

RUN apt update && apt install -y bash vim openjdk-8-jdk-headless openssh-server openssh-client curl 

# passwordless ssh, update to use pregenerated keys.
RUN rm -rf /etc/ssh/ssh_host_dsa_key && ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_dsa_key 
RUN rm -rf /etc/ssh/ssh_host_rsa_key && ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key 
RUN rm -rf /root/.ssh/id_rsa && ssh-keygen -q -N "" -t rsa -f /root/.ssh/id_rsa 
RUN cp -f /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys

#http://mirror.ox.ac.uk/sites/rsync.apache.org/hadoop/common/hadoop-2.9.2/hadoop-2.9.2.tar.gz
RUN curl -L http://mirror.ox.ac.uk/sites/rsync.apache.org/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz -o /tmp/hadoop.tar.gz \
    && tar xzfv /tmp/hadoop.tar.gz -C /tmp/ \
    && mv -v /tmp/hadoop-${HADOOP_VERSION} ${HADOOP_HOME} \
    && mkdir -pv ${ENTRYPOINT_SCRIPT_DIR}

COPY ./files/hadoop/* ${HADOOP_HOME}/etc/hadoop/
COPY ./files/init_scripts/* ${ENTRYPOINT_SCRIPT_DIR}/
COPY ./files/ssh/ssh_config /etc/ssh/

#Configure hadoop data dirs
RUN mkdir -pv ${HADOOP_DATA_NODE_DATA} \
        && mkdir -pv ${HADOOP_NAME_NODE_DATA} \
        && mkdir -pv ${HADOOP_TEMPDIR} \
        && mkdir -pv ${ENTRYPOINT_SCRIPT_DIR}

ENV MAPRED_EXAMPLES=/opt/hadoop/share/hadoop/mapreduce/hadoop-mapreduce-examples-2.9.2.jar
