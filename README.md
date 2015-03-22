# pqs

This `postgres` service intended to be used only on development phase.

`pqs` designed for one-time use because it used for development only.
no persistent volume. Easy to start, easy to destroy.

## Image

### Build image

    $ docker build -t TAG .

### Run a container

    $ docker run -d --name postgres TAG

### Stop a container

    $ docker stop postgres

### Run stopped container

    $ docker start postgres

## Services
TODO: bedakan image sama service!

## Database maintenance

### Installation method
Instalation using debian package. No need to initialize
database cluster. Because standart installation already creates
a default cluster.

### Configuration file
Default installation `/etc/postgresql/9.3/main/postgresql.conf`

### Where is data saved? (database directory)
Default debian installation use `/var/lib/postgresql/9.3/main`

### Host Based Authentication file
This file for setting up client authentication.
Default installation `/etc/postgresql/9.3/main/pg_hba.conf`

### Create extra user and database

    TODO: Create username, password and database outside
    Dockerfile due security reason.

Initialize extra user & create new database in `Dockerfile`
with command below:

    RUN /etc/init.d/postgresql start &&\
        psql --command "CREATE USER bayu WITH SUPERUSER PASSWORD 'bayu';" &&\
        createdb -O bayu automata

NOTE: this command must running as `postgres` user.


## Manage data
Manage data on `postgres` server container using running `postgres` client
container as a client.

Make sure `postgres` container already running

    $ docker ps
    CONTAINER ID        IMAGE               COMMAND                CREATED             STATUS              PORTS               NAMES
    9e4232251c2d        bayu/pqs:v0         "/usr/lib/postgresql   10 hours ago        Up 2 seconds        5432/tcp            pg_server

Then run a `postgres` client based on same image to manage data. Don't forget
to link `pg_server` to `pg_client`

    $ docker run -it --name pg_client --entrypoint /bin/bash --link pg_server:database bayu/pqs:v0

Now you are ready to manage data using `psql`

    $ psql -h database -U bayu -d automata


## Todo
-   configure timezone to GMT+7
-   dynamically configured user and password for database
