#Users in PSQL
#list users
\du
#create user
postgres-# createuser test_user
postgres-# alter user test_user with password 'MyDBpassword';
postgres-# createdb test_db -O test_user
postgres-# grant all privileges on database test_db to test_user;
GRANT
#Login as a test_user  user try to create a table on the Database.
psql -U test_user -h localhost -d test_db
#logis as postgres
sudo -u postgres psql
#set passwd for user postgres
ALTER USER postgres PASSWORD '12345';

#see in postgres data dir
postgres=# show data_directory;
       data_directory        
-----------------------------
 /var/lib/postgresql/12/main
(1 row)

#see what filename for DB
postgres=# SELECT oid,datname from pg_database;
  oid  |       datname       
-------+---------------------
 13427 | postgres
 16385 | mastodon_production
     1 | template1
 13426 | template0
 17787 | benchmark
(5 rows)



#list db and tables
#ist all databases
list or \l
#list all tables in the current database using your search_path
\dt
#list all tables in the current database regardless your search_path
\dt *.
#connect to database
\c database_name
#show tables in database
select * from table_name;
#insert values in table
INSERT INTO auth_user (password, username, is_superuser) VALUES ('test', 'test', TRUE);

#pgbench
#create 15G test-db "banchmark"
pgbench -h localhost -U postgres -i -s 1000 benchmark
#check db
du -shc /var/lib/postgresql/12/main/base/17787/
15G	/var/lib/postgresql/12/main/base/17787/
15G	total
#test
pgbench -h localhost -U postgres -c 50 -j 2 -P 60 -T 600 benchmark


#check version
sudo -u postgres psql --version


#psql
sudo su - postgres
#create superuser
postgres=# create user elma with encrypted password 'PostgresStr0ngPassw0rd';
CREATE ROLE
postgres=# alter user elma with superuser;
ALTER ROLE
postgres=#

postgres=# alter user postgres_tst_user with password 'PostgresStr0ngPassw0rd#';
postgres=#  create user silvergate_db_user with encrypted password 'PostgresStr0ngPassw0rd';
postgres=# grant all privileges on database silvergate_db to silvergate_db_user;
postgres-# create database silvergate_db;
#or
sudo -u postgres createuser postgres_tst_user

#allow net connect
vi /var/lib/pgsql/14/data/postgresql.conf
listen_addresses = '*'

vi /var/lib/pgsql/14/data/pg_hba.conf
host  all  all 0.0.0.0/0 md5



# add db_user to superuser ( can create DB)
postgres=# ALTER USER silvergate_db_user WITH SUPERUSER;
#
postgres=# ALTER USER test_user WITH NOSUPERUSER;



#Ubuntu 20-04 Configs
/etc/postgresql/14/main/postgresql.conf
/etc/postgresql/14/main/pg_hba.conf
