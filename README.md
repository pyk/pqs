# pqs

postgresql service

## Service

### Building service

    $ docker build -t bayu/pqs:v0 .

### Running service

    $ docker run -d --name postgres bayu/pqs:v0

## Database maintenance

### Installation method   
Instalation using debian package. No need to initialize
database cluster. Because standart install already creates
a default cluster.

### Configuration file   
Default installation /etc/postgresql/9.3/main/postgresql.conf

### Where is data saved? (database directory)   
Default debian installation use /var/lib/postgresql/9.3/main

### Host Based Authentication file   
This file for setting up client authentication.
Default installation /etc/postgresql/9.3/main/pg_hba.conf 

### Create extra user and database   

    TODO: Create username, password and database outside
    Dockerfile due security reason.

Initialize extra user & create new database in `Dockerfile` 
with command below:

    RUN /etc/init.d/postgresql start &&\
        psql --command "CREATE USER bayu WITH SUPERUSER PASSWORD 'bayu';" &&\
        createdb -O bayu automata

NOTE: this command must running as `postgres` user.


### Manage table

3.  How to create table?
4.  How to alter table?


## Todo

-   configure timezone to GMT+7
-   use persistent storage for database directory, sync with
    container data-only
-   dynamically configured user and password for database