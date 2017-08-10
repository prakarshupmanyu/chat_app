# README

This work is being done on RoR version 5.1.3 and ruby version 2.4.0.

Make sure the following MySql database have been creatd before trying to run the code. I might have missed out a few things for which I apologize in advance.

Create databases and database users:

create database chat_app_development;

create database chat_app_test;

grant all privileges on chat_app_development.* to 'chat_app_user'@'localhost' identified by 'P@ssw0rd';

grant all privileges on chat_app_test.* to 'chat_app_user'@'localhost' identified by 'P@ssw0rd';

