# EasyMySql #
## A docker container to provide MySQL databases on the fly ##

Docker is an open-source engine that automates the deployment of applications
as portable and self-sufficient containers that will run virtually anywhere.
Dockerized applications reduce configuration efforts and obstacles
for administrators. Applications (e.g. databases) can be provided in a configured,
self-contained and frictionless way.

## Intended usage ##

This Dockerfile is used to provide MySQL databases in a frictionless
but flexible way. The requirement was to provide different
MySQL based relational databases for computer science students
for educational purposes (database/webtechnology lectures).
Nevertheless, the approach can be used
for similar purposes in complete different domains.

Whenever you have to

- provide data as a relational database via MySQL
- with user based access requirement
- for demonstrational purposes (throw-away database)
- in an ad hoc way

this container might be solve your problem.

__Warning: You should not use this container for production purposes.__

## Prerequisites ##

You have to install [Docker](http://www.docker.com).

If you are using Linux, you are fine. Docker installation on Linux is less
complicated than for other operating systems. Docker is a
operating system virtualization tool chain for Linux. Therefore installation
gets only complicated if you are leaving the Linux ecosystem.

You will find Docker installation instructions
for a lot of Linux distributions [here](http://docs.docker.com/installation/).

But no worries. If you are using __Windows__ (why ever) or __Mac OS X__ (like me) simply
follow the [boot2docker](http://boot2docker.io) installation instructions
for

- [Windows](https://github.com/boot2docker/windows-installer/releases) or
- [Mac OS X](https://github.com/boot2docker/osx-installer/releases)

## Usage ##

Start Boot2Docker according to your operating system. You can skip this step if
you are working on a Linux system.

First you have to build a image. This image provides a self-contained MySQL
server. You can clone this repository or tell docker to do the repository handling
behind the scenes for you (which is my preferred way in case of github provided
  Dockerfiles):

```Shell
docker build -t mysqldb github.com/nkratzke/mysqldb
```

Now you have an image named *mysqldb* on your system, capable to
provide MySQL databases. The simplest way to do this is, is like that:

```Shell
docker run -d -p 3306:3306 mysqldb
```

It will create a running container on your system providing a MySQL server on port 3306.

- Container will provide a standard database (I use for demonstration purposes in some of my lectures).
- MySQL server has a user called *student* with a password called *secret*

You can figure out that the container is running

```Shell
docker ps
```

and docker returns an output like that.

```Shell
CONTAINER ID        IMAGE               COMMAND                CREATED             STATUS              PORTS                    NAMES
85fbad3eb5ce        mysqldb:latest      "/usr/local/bin/star   56 minutes ago      Up 55 minutes       0.0.0.0:3306->3306/tcp   focused_lalande
```

To stop a container simply figure out its CONTAINER ID and stop it like that

```Shell
docker stop 85fbad3eb5ce
```

Nevertheless the container is capable to do more.

### Use own database(s) ###

```Shell
docker run -d -p 3306:3306 -e url="http://www.example.org/my/database.sql" mysqldb
```

### Define user ###

You can create your own user with own password at container startup.
The created MySQL user will get read access to all databases hosted in this container.

```Shell
docker run -d -p 3306:3306 -e user="Nane" -e password="meins" mysqldb
```

And of course you can combine own database and user.

### Access rights ###

You can change the access rights of your database.

- read (which is mapped to GRANT SELECT on all databases) [DEFAULT]
- write (GRANT ALL PRIVILEGES WITH OPTIONS on all databases, so this is power user is able to do everything)

Be aware! If you are granting write access to the user, the user be able to do everything
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

Read access is perfect for providing datasets. E.g. databases for students
they should use to answer questions. It is assured that no student can
destroy the database accidentally.

If you want to create a user with complete write access to your database
you can run

```Shell
docker run -d -p 3306:3306 -e user="Nane" -e password="meins" -e right="WRITE" mysqldb
```

which will provide full access to the database for user *Nane*.

Write access is perfect to provide databases which can be administered by the
user. E.g. for students who have to set up a data models from scratch but should not
have to deal with nitty critty MySQL installation and configuration. Nevertheless
they have to be aware that the user can do arbitrary harm to the database.
So normally a user with write access should create users with a more restrictive
set of rights for the database. But this is up to the user.

And of course you can combine own database, user and access rights.

### Tips for troubleshooting ###

If you want to provide your own databases you must assure that your database definition
file provided via the <code>url</code> parameter is valid and processable by MySQL.

If it works in MySQL Workbench it should work with this container.

Nevertheless, if your are running into troubles you should start your container
with the <code>-t</code> parameter of docker. This will forward the output of the container
to your console, which is likely to be helpful for debugging purposes.

```Shell
docker run -t -p 3306:3306 -e urldb="http://www.ex.org/my/database.sql" mysqldb
```
