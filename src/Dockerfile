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
ENV JAVA_HOME=/usr/lib/jvm/default-java



RUN apt-get update \
    && apt-get -y install curl default-jre ssh \
    && mkdir ${HADOOP_CONFIG_DIR}

#copy hadoop config files
COPY ./files/ ${HADOOP_CONFIG_DIR}/

# passwordless ssh
RUN rm -rf /etc/ssh/ssh_host_dsa_key && ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_dsa_key 
RUN rm -rf /etc/ssh/ssh_host_rsa_key && ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key 
RUN rm -rf /root/.ssh/id_rsa && ssh-keygen -q -N "" -t rsa -f /root/.ssh/id_rsa 
RUN cp -f /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys

#grab hadoop
#RUN curl -L http://mirrors.london-do.gethosted.online/apache/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz -o /tmp/hadoop.tar.gz \
RUN curl -L 192.168.1.127:8000/hadoop-3.2.0.tar.gz -o /tmp/hadoop.tar.gz \
    && tar xzfv /tmp/hadoop.tar.gz -C /opt/ \
    && mv /opt/hadoop-${HADOOP_VERSION} ${HADOOP_PATH} \
    && cp -rf ${HADOOP_CONFIG_DIR}/hadoop/* ${HADOOP_PATH}/ 

ENV HDFS_NAMENODE_USER="root"
ENV HDFS_DATANODE_USER="root"
ENV HDFS_SECONDARYNAMENODE_USER="root"
ENV YARN_RESOURCEMANAGER_USER="root"
ENV YARN_NODEMANAGER_USER="root"

RUN hdfs namenode -format ${CLUSTER_NAME} \
    && echo "JAVA_HOME=\"${JAVA_HOME}\"" >> /etc/environment \
    && /etc/init.d/ssh start \ 
    && start-dfs.sh
    
    ##
    #Configure $HADOOP_CONF_DIR/slaves
    #Call sbin/start-dfs.sh
    ##
