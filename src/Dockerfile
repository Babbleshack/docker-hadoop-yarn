FROM ubuntu:latest

MAINTAINER Babbleshack <dcrl94@gmail.com> Version: 0.1

ARG HADOOP_VERSION=3.2.0
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
#ENV JAVA_HOME=/usr/lib/jvm/default-jvm
ENV JAVA_HOME=/usr/lib/jvm/default-java

ENV HDFS_NAMENODE_USER="root"
ENV HDFS_DATANODE_USER="root"
ENV HDFS_SECONDARYNAMENODE_USER="root"
ENV YARN_RESOURCEMANAGER_USER="root"
ENV YARN_NODEMANAGER_USER="root"

#RUN apk add --no-cache bash vim openjdk8-jre openssh curl \
    #        && mkdir /opt
RUN apt update && apt install -y bash vim default-jre openssh-server openssh-client curl 

# passwordless ssh
RUN rm -rf /etc/ssh/ssh_host_dsa_key && ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_dsa_key 
RUN rm -rf /etc/ssh/ssh_host_rsa_key && ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key 
RUN rm -rf /root/.ssh/id_rsa && ssh-keygen -q -N "" -t rsa -f /root/.ssh/id_rsa 
RUN cp -f /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys

#grab hadoop
    #RUN curl -L 192.168.1.127:8000/hadoop-3.2.0.tar.gz -o /tmp/hadoop.tar.gz \
RUN curl -L http://mirrors.london-do.gethosted.online/apache/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz -o /tmp/hadoop.tar.gz \
    && tar xzfv /tmp/hadoop.tar.gz -C /tmp/ \
    && mv -v /tmp/hadoop-${HADOOP_VERSION} ${HADOOP_HOME} \
    && mkdir -pv ${ENTRYPOINT_SCRIPT_DIR}
    #&& cp -rf ${HADOOP_CONFIG_DIR}/hadoop/* ${HADOOP_HOME}/ 

#copy hadoop config files
#COPY ./files/etc ${HADOOP_CONF_DIR}
COPY ./files/etc ${HADOOP_HOME}/etc
COPY ./files/* ${ENTRYPOINT_SCRIPT_DIR}/

#Configure hadoop data dirs
RUN mkdir -pv ${HADOOP_HOME}/hdfs/namenode \
        && mkdir -pv ${HADOOP_HOME}/hdfs/datanode \
        && mkdir -pv ${HADOOP_HOME}/hadooptmpdata \
        && mkdir -pv ${ENTRYPOINT_SCRIPT_DIR}

#EXPOSE 50070
EXPOSE 9870

#Why cant I use environment vars here (e.g. $ENTRYPOINT_SCRIPT_DIR) 
#ENTRYPOINT [ "/opt/init_container.d/start_namenode.sh" ]
#ENTRYPOINT [ "/opt/init_container.d/start_psudo_dfs.sh" ]
#CMD [ "tail -f /opt/hadoop/logs/hadoop-namenode-*.log"]

#RUN hdfs namenode -format ${CLUSTER_NAME} \
    #    && echo "JAVA_HOME=\"${JAVA_HOME}\"" >> /etc/environment \
    #    && /etc/init.d/ssh start \ 
    #    && start-dfs.sh
    
    ##
    #Configure $HADOOP_CONF_DIR/slaves
    #Call sbin/start-dfs.sh
    ##
