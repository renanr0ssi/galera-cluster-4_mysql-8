# Baixar imagem de SQL Server 2019 com Ubuntu 20.10:
FROM ubuntu:20.10

# informa o Mantenedor dessa imagem (Você pode colocar seu prórpio nome):
MAINTAINER Renan Rossi <renan.rossi@outlook.com>

# Seta algumas variáveis:
ENV VERSION 20200710
ENV DEBIAN_FRONTEND noninteractive

# Atualiza a imagem e instala aplicações:
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y  software-properties-common && \
    apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 BC19DDBA && \
    apt-get update && \
    apt-get install -y galera-4 mysql-server-8.0  rsync lsof iputils-ping nano
#RUN rm -r /var/lib/mysql/

# Copia arquivo de configuração do MySql previamente preparado:
COPY my.cnf /etc/mysql/my.cnf

# Copia arquivo de entrypoint e seta permissão (porém não o executa pois estava dando alguns problemas):
COPY entrypoint.sh /entrypoint.sh
RUN chmod 700 /entrypoint.sh
#ENTRYPOINT ["/entrypoint.sh"]

#Expor as portas necessárias:
EXPOSE 3306 4444 4567 4568

# Informa a Label:
LABEL mysql_version=8.0
