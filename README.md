# EasyMySQL #

[docker]: https://dev.mysql.com/downloads/workbench/

__A docker container to provide MySQL databases on the fly.__

This Dockerfile is used to provide MySQL databases in a frictionless
but flexible way. The requirement was to provide different
MySQL based relational databases for computer science students
for educational purposes (database/webtechnology lectures and labs).
Nevertheless, the approach can be used
for similar purposes in complete different domains.

Whenever you have to

- provide data as a relational database via MySQL
- with user based access requirement
- for demonstrational purposes (throw-away database)
- in an ad hoc way

this container might be of interest to you.

__Warning: You should not use this container for production purposes.__

## Prerequisites ##

First, you have to install [Docker](docker).

If you are using Linux, you are fine. You will find Docker installation instructions
for a lot of Linux distributions [here](http://docs.docker.com/installation/).

But no worries. If you are using __Windows__ (why ever) or __Mac OS X__ (like me) simply
follow the [boot2docker](http://boot2docker.io) installation instructions
for

- [Windows](https://github.com/boot2docker/windows-installer/releases) or
- [Mac OS X](https://github.com/boot2docker/osx-installer/releases)

## Usage ##

To use this container you have to build an image as a first step. This image provides a self-contained MySQL
server. You can clone this repository or tell docker to do the repository handling
behind the scenes for you (which is my preferred way in case of github provided
  Dockerfiles):

```Shell
docker build -t mysqldb github.com/nkratzke/easymysql
```

Now you have an image named *mysqldb* on your system, capable to
provide MySQL databases. The simplest way to do start a database is like that:

```Shell
docker run -d -p 3306:3306 mysqldb
```

It will create a running container on your system providing a MySQL server.

- Container will provide a standard database (I use for demonstration purposes in some of my lectures).
- MySQL server has a user called *student* with a password called *secret*
- The database is reachable on port 3306 (standard MySQL Port)

If you want to run your database on a different port than 3306 just do the following:

```Shell
docker run -d -p 4407:3306 mysqldb
```

to run it on port 4407 (for instance). You can figure out that the container is running

```Shell
docker ps
```

and docker returns an output like that.

```Shell
CONTAINER ID        IMAGE               COMMAND                CREATED             STATUS              PORTS                    NAMES
85fbad3eb5ce        mysqldb:latest      "/usr/local/bin/star   56 minutes ago      Up 55 minutes       0.0.0.0:3306->3306/tcp   focused_lalande
```

To check whether the database is working, you can connect to it.
Figure out what address your docker host has. If you are working with Boot2Docker
you can do this

```Shell
boot2docker ip
```

and you will get an answer like that:

```Shell
The VM's Host only interface IP address is: 192.168.59.104
```

Now you have all to connect to your MySQL database. To check that everything is fine
just start [MySQLWorkbench](https://dev.mysql.com/downloads/workbench/) and
enter the following parameters when creating a new database connection:

- __Hostname:__ IP address or DNS name of your docker host (when you are working with boot2docker its the ip you get via <code>boot2docker ip</code>)
- __Username:__ *student* (you can change this, we will come to this later)
- __Password:__ *secret* (you can change this, we will come to this later)
- __Default Schema:__ *LVBsp* (you can change the database as well, so stay tuned)

To stop a container simply figure out its CONTAINER ID (via <code>docker ps</code> as shown above)
and stop it like that:

```Shell
docker stop 85fbad3eb5ce
```

The above mentioned standard database is a read only default database. Not very helpful
(except for me and my lectures).
But the container is capable to do more by providing a set of parameters.

- <code>user</code> and <code>password</code> to define your own user
- <code>right</code> to define whether you want to provide just read or full access rights
- <code>url</code> to provide an arbitrary sql file (UTF8 encoded) to deliver your own database

So let's figure out some details.

### Use your own database(s) with <code>url</code>###

You can provide your own database via a sql file when you start your container.
Just use the <code>url</code> parameter to point to a valid sql file.
This file can be hosted anywhere (accessible from your docker host).

__Attention!__ SQL file is assumed to be encoded as UTF8 and has to valid as well as non interactively processable by mysql.

```Shell
docker run -d -p 3306:3306 -e url="http://www.example.org/my/database.sql" mysqldb
```

### Define user with <code>user</code> and <code>password</code>###

You can create your own user/password combination by using the <code>user</code> and
<code>password</code> parameter.
By default the created MySQL user will get read access to all databases hosted by this container.

```Shell
docker run -d -p 3306:3306 -e user="Nane" -e password="meins" mysqldb
```

### Change access rights with <code>right</code>###

You can change the access rights of your database.

- <code>READ</code> (which is mapped to GRANT SELECT on all databases) __[DEFAULT]__
- <code>WRITE</code> (GRANT ALL PRIVILEGES WITH OPTIONS on all databases, so this is a power user beeing able to do everything)

__Hint! Access rights have to be written completely in uppercase.
So <code>Write</code> is not recognized as <code>WRITE</code>!!!__

Be aware! If you are granting write access to the user, the user is able to do everything
with the database including

- create new databases
- drop existing databases
- insert and modify data
- create or drop users
- changes rights of existing users
- shutdown databases and so on.

The read access right is the default one. So

```Shell
docker run -d -p 3306:3306 -e right="READ" mysqldb
```

is synonym to


```Shell
docker run -d -p 3306:3306 mysqldb
```

Read access is perfect for providing read-only datasets. E.g. databases for students
they should use to answer questions. By providing a database read-only
it is assured that no student can destroy the database accidentally.

If you want to create a user with complete write access to your database
you can run something like that

```Shell
docker run -d -p 3306:3306 -e user="Me" -e password="mine" -e right="WRITE" mysqldb
```

which will provide __full access__ to the database for user *Me*.

Write access is perfect to provide databases, which can be administered by the
user. E.g. for students who have to set up a data model from scratch but should not
have to deal with nitty critty MySQL server installation and configuration. Nevertheless
they have to be aware that the user can do arbitrary harm to the database.
So normally a user with write access should create users with a more restrictive
set of rights for the database. But this is up to the user.

### Tips for troubleshooting ###

If you want to provide your own databases, you must assure that your database definition
file provided via the <code>url</code> parameter is valid and processable by MySQL as well as 
downloadable by curl (which is used behind the scenes to do that).

If it works in MySQL Workbench, it should work with this container.

Nevertheless, if your are running into troubles you should start your container
with the <code>-t</code> and <code>-i</code> parameter of docker. This will forward the output of the container
to your console, which is likely to be helpful for debugging purposes.

```Shell
docker run -t -i -p 3306:3306 -e url="http://www.ex.org/my/database.sql" mysqldb
```
