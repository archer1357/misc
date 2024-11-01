CREATE OR REPLACE TABLE persons (
pid int AUTO_INCREMENT PRIMARY KEY,
firstname varchar(255),
lastname varchar(255),
age int
);

insert into persons (firstname,lastname,age) values ("will","smith",17);
insert into persons (firstname,lastname,age) values ("bob","smith",217);

select * from persons where lastname="smith" order by firstname;
select * from persons;

--mysql -ppass -uroot -Dtest -halarmpi