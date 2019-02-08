FROM ubuntu:xenial

MAINTAINER Babbleshack Version: 0.1


ARG HADOOP_VERSION=3.2.0
ARG HADOOP_CONFIG_DIR=/opt/hadoop-config
ARG HADOOP_PATH=/opt/hadoop 
ARG CLUSTER_NAME=docker_hadoop_cluster

ENV HADOOP_YARN_HOME=/opt/hadoop
ENV HADOOP_INSTALL=${HADOOP_YARN_HOME}
ENV HADOOP_MAPRED_HOME=${HADOOP_YARN_HOME}
ENV HADOOP_COMMON_HOME=${HADOOP_YARN_HOME}
ENV HADOOP_HDFS_HOME=${HADOOP_YARN_HOME}
ENV YARN_HOME=${HADOOP_YARN_HOME}
ENV HADOOP_COMMON_LIB_NATIVE_DIR=${HADOOP_YARN_HOME}/lib/native
ENV PATH=${PATH}:${HADOOP_YARN_HOME}/sbin:${HADOOP_YARN_HOME}/bin
ENV HADOOP_OPTS="-Djava.library.path=${HADOOP_YARN_HOME}/lib/native"
ENV HADOOP_CONF_DIR=${HADOOP_YARN_HOME}/etc



RUN apt-get update && \
    apt-get -y install curl  && \
    apt-get -y install default-jre && \
    mkdir ${HADOOP_CONFIG_DIR}

#copy hadoop config files
COPY ./files/ ${HADOOP_CONFIG_DIR}/

RUN curl -L http://mirrors.london-do.gethosted.online/apache/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz -o /tmp/hadoop.tar.gz \
    && tar xzfv /tmp/hadoop.tar.gz -C /opt/ \
    && mv /opt/hadoop-${HADOOP_VERSION} ${HADOOP_PATH} \
    && cp -rf ${HADOOP_CONFIG_DIR}/hadoop/* ${HADOOP_PATH}/ 

RUN ${HADOOP_CONFIG_DIR}/env.sh \
    && hdfs namenode -format ${CLUSTER_NAME} 
    
    ##
    #Configure $HADOOP_CONF_DIR/slaves
    #Call sbin/start-dfs.sh
    ##
