FROM babbleshack/hadoop:base

MAINTAINER Babbleshack <dcrl94@gmail.com> Version: 0.1

ENV ENTRYPOINT_SCRIPT_DIR=/opt/init_container.d

COPY ./files/hadoop/etc ${HADOOP_HOME}/etc
COPY ./files/init_scripts/* ${ENTRYPOINT_SCRIPT_DIR}/
#Why cant I use environment vars here (e.g. $ENTRYPOINT_SCRIPT_DIR) 
ENTRYPOINT [ "/opt/init_container.d/start_datanode.sh" ]
