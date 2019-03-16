FROM babbleshack/hadoop:base

MAINTAINER Babbleshack <dcrl94@gmail.com> Version: 1.0

EXPOSE 8088/tcp
EXPOSE 8030/tcp
EXPOSE 8031/tcp
EXPOSE 8032/tcp
EXPOSE 8033/tcp
EXPOSE 8020/tcp
EXPOSE 9000/tcp
EXPOSE 50070/tcp

ENTRYPOINT [ "/opt/init_container.d/start_master.sh" ]
