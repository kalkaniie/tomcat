use mysql;
update user set password=password('kebi') where user='root';
flush privileges;
grant all privileges on *.* to 'root'@'127.0.0.1' identified by 'kebi' with grant option;
grant all privileges on *.* to 'root'@'211.238.156.130' identified by 'kebi' with grant option;
select host, user, password from user where user='root';
grant all privileges on *.* to 'kebi'@'127.0.0.1' identified by 'kebi' with grant option;
grant all privileges on *.* to 'kebi'@'211.238.156.130' identified by 'kebi' with grant option;
grant all privileges on *.* to 'kebi'@'localhost' identified by 'kebi' with grant option;
select host, user, password from user where user='kebi';
create database mail;
show databases;
exit

