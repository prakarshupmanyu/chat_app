# README

1 - Create databases and database users:

create database chat_app_development;
create database chat_app_test;
grant all privileges on chat_app_development.* to 'chat_app_user'@'localhost' identified by 'P@ssw0rd';
grant all privileges on chat_app_test.* to 'chat_app_user'@'localhost' identified by 'P@ssw0rd';

2 - Uncomment bcrypt from Gemfile and run bundle install. This is for Blowfish encryption.
