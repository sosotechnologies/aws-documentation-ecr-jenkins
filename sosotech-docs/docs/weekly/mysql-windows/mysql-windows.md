# MySQL Windows

## Installation
Community Edition Link: [LINK](https://dev.mysql.com/downloads/mysql/)

## setup a minikube cluster

```
choco install minikube
```

```
minikube start
```

***Alter password in workbench***

```
alter user 'root'@'localhost' identified with mysql_native_password by 'your-soso-password';

QUIT
```

***Create a Database***

```
SHOW DATABASES;
CREATE DATABASE sosotech;
USE sosotech;
```

***Create Tables in the Database***

```
CREATE TABLE sosologin
(
  id              INT unsigned NOT NULL AUTO_INCREMENT, # Unique ID for the record
  name            VARCHAR(150) NOT NULL,                # Name of the cat
  owner           VARCHAR(150) NOT NULL,                # Owner of the cat
  birth           DATE NOT NULL,                        # Birthday of the cat
  PRIMARY KEY     (id)                                  # Make the id the primary key
);
```

```
DESCRIBE sosologin
```

Adding records into a table.

```
INSERT INTO sosologin ( name, owner, birth) VALUES
  ( 'Collins', 'Macaz', '2004-01-03' ),
  ( 'Macaz', 'Macaz', '2014-11-13' ),
  ( 'Collins', 'Afa', '2012-05-21' );
```

Retrieving records from a table.

```
SELECT * FROM sosologin;

SELECT name FROM sosologin WHERE owner = 'afa';
```
For more info: [SEE LINK](https://dev.mysql.com/doc/mysql-getting-started/en/)