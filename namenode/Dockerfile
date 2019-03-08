FROM babbleshack/hadoop:base-2-9-2

MAINTAINER Babbleshack <dcrl94@gmail.com> Version: 0.1

COPY ./files/* ${ENTRYPOINT_SCRIPT_DIR}/
EXPOSE 9870
#Why cant I use environment vars here (e.g. $ENTRYPOINT_SCRIPT_DIR) 
ENTRYPOINT [ "/opt/init_container.d/start_namenode.sh" ]
