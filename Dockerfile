FROM debian:wheezy
MAINTAINER Bayu Aldi Yansyah <bayualdiyansyah@gmail.com>

# installing postgresql
RUN apt-get update && apt-get install wget -y &&\
    echo 'deb http://apt.postgresql.org/pub/repos/apt/ wheezy-pgdg main' > /etc/apt/sources.list.d/pgdg.list &&\
    wget --no-check-certificate --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - &&\
    apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install postgresql-9.3 postgresql-contrib-9.3 -y

# post-installation
# run the rest command as postgres user
# postgres user auto created when installing postgresql pkg
USER postgres

# start postgresql service
RUN /etc/init.d/postgresql start &&\
    psql --command "CREATE USER bayu WITH SUPERUSER PASSWORD 'bayu';" &&\
    createdb -O bayu automata

# setup host based authentication
RUN echo "host all  all    0.0.0.0/0  md5" >> /etc/postgresql/9.3/main/pg_hba.conf
RUN echo "listen_addresses='*'" >> /etc/postgresql/9.3/main/postgresql.conf

# expose port
EXPOSE 5432

# mount data volumes
VOLUME  ["/etc/postgresql", "/var/log/postgresql", "/var/lib/postgresql"]

CMD ["/usr/lib/postgresql/9.3/bin/postgres", "-D", "/var/lib/postgresql/9.3/main", "-c", "config_file=/etc/postgresql/9.3/main/postgresql.conf"]