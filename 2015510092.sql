create database "EventManagement";

--creating "categories" table
create table categories
(
	"categoryid" int not null,
	"name" varchar(20),
	constraint "pk_categoryid" primary key("categoryid")
);

--creating "events" table
create table events
(
	"eventid" int not null,
	"categoryid" int not null,
	"name" varchar(30),
	"address" varchar(40),
	"county" varchar(20),
	"city" varchar(20),
	"startdate" date,
	"enddate" date,
	"price" int,
	"quota" int,
	"discountrate" int,
	constraint "pk_eventid" primary key("eventid"),
	constraint "fk_categoryid" foreign key("categoryid") references categories("categoryid")
	match simple on update cascade on delete cascade
);

--creating "members" table
create table members
(
	"memberid" int not null,
	"name" varchar(20),
	"surname" varchar(20),
	"username" varchar(20),
	"password" varchar(20),
	"birthdate" date,
	"e_mail" varchar(30),
	"member_ship" varchar(20),
	constraint "pk_memberid" primary key("memberid")
);

--creating "participation" table
create table participation
(
	"memberid" int not null,
	"eventid" int not null,
	constraint "p_keys" primary key("memberid", "eventid")
);

--creating "organizators" table
create table organizators
(
	"organizatorid" int not null,
	"name" varchar(30),
	"username" varchar(20),
	"password" varchar(20),
	constraint "pk_organizatorid" primary key("organizatorid")
);

--creating "organization" table
create table organization
(
	"organizationid" int not null,
	"organizatorid" int not null,
	"eventid" int not null,
	"name" varchar(20),
	"phone" varchar(20),
	constraint "pk_organizationid" primary key("organizationid"),
	constraint "fk1_organizatorid" foreign key("organizatorid") references organizators("organizatorid")
	match simple on update cascade on delete cascade,
	constraint "fk2_eventid" foreign key("eventid") references events("eventid")
	match simple on update cascade on delete cascade
);

--inserting into "categories" table
insert into categories("categoryid", "name")
values(1,'cultural');
insert into categories("categoryid", "name")
values(2,'social');
insert into categories("categoryid", "name")
values(3,'academic');

--inserting into "events" table
insert into events("eventid", "categoryid", "name", "address", "county", "city", "startdate", "enddate", "price", "quota", "discountrate")
values(1,1,'travel','zafer mah','Turkey', 'izmir','2019-5-27', '2019-6-15', 4000, 50, 0);
insert into events("eventid", "categoryid", "name", "address", "county", "city", "startdate", "enddate", "price", "quota", "discountrate")
values(2,2,'music','anka mah','Turkey', 'istanbul','2019-5-30', '2019-6-1', 200, 500, 0);
insert into events("eventid", "categoryid", "name", "address", "county", "city", "startdate", "enddate", "price", "quota", "discountrate")
values(3,3,'conference','taş mah','Turkey', 'izmir','2019-5-19', '2019-5-23', 0, 400, 0);
insert into events("eventid", "categoryid", "name", "address", "county", "city", "startdate", "enddate", "price", "quota", "discountrate")
values(4,1,'holiday','tömük mah','Turkey', 'mersin','2019-6-1', '2019-8-20', 9000, 200, 0);

--inserting into "members" table
insert into members("memberid", "name", "surname", "username", "password", "birthdate", "e_mail", 	"member_ship")
values(1, 'mustafa', 'ince', 'mstfkrm', '104105m', '1996-10-2', 'mustafa@gmail.com', 'standart');
insert into members("memberid", "name", "surname", "username", "password", "birthdate", "e_mail", 	"member_ship")
values(2, 'ahmet', 'tuna', 'ahmet123', 'ahmet999', '1963-1-1', 'ahmet@gmail.com', 'standart');
insert into members("memberid", "name", "surname", "username", "password", "birthdate", "e_mail", 	"member_ship")
values(3, 'cemal', 'taş', 'cms23', 'c190526', '1995-6-2', 'cemal@gmail.com', 'standart');
insert into members("memberid", "name", "surname", "username", "password", "birthdate", "e_mail", 	"member_ship")
values(4, 'cemil', 'şimşek', 'cemil128', 'cemil4956', '1983-4-1', 'cemil@gmail.com', 'standart');
insert into members("memberid", "name", "surname", "username", "password", "birthdate", "e_mail", 	"member_ship")
values(5, 'ayşe', 'bulut', 'ayşe33', 'sifre123', '1977-8-1', 'ayse@gmail.com', 'standart');

--inserting into "participation" table
insert into participation("memberid", "eventid")
values(1,1);
insert into participation("memberid", "eventid")
values(1,2);
insert into participation("memberid", "eventid")
values(1,3);
insert into participation("memberid", "eventid")
values(2,3);
insert into participation("memberid", "eventid")
values(3,1);
insert into participation("memberid", "eventid")
values(4,1);

--inserting into "organizator" table
insert into organizators("organizatorid", "name", "username", "password")
values(1, 'Dokuz Eylul University', 'DEU', 'deu1299');
insert into organizators("organizatorid", "name", "username", "password")
values(2, 'Hikmet Görkem', 'hikmet', 'hikmet123');
insert into organizators("organizatorid", "name", "username", "password")
values(3, 'Hasan Basri', 'basri59', 'hasbas33');

--inserting into "organization" table
insert into organization("organizationid", "organizatorid", "eventid", "name", "phone")
values(1,1,3,'for good future', '05353541268');
insert into organization("organizationid", "organizatorid", "eventid", "name", "phone")
values(2,2,1,'a good travel', '05371234578');
insert into organization("organizationid", "organizatorid", "eventid", "name", "phone")
values(3,3,2,'dance with music', '02123547897');
insert into organization("organizationid", "organizatorid", "eventid", "name", "phone")
values(4,2,2,'music club', '05342569713');

--SQL queries

--query 1
select * from events where city='izmir';

--query 2
select e.name as eventName, ct.name as categoryName
from events as e, categories as ct
where e.categoryid = ct.categoryid and
e.eventid in
(select pr.eventid
from participation as pr
group by pr.eventid order by count(*) desc limit 1)

--query 3
select count(*) as event_num, cat.name as category_name
from events as e
inner join categories as cat on e.categoryid = cat.categoryid
group by cat.categoryid order by count(*) desc;

--query 4
select *
from events
where eventid in
(select distinct eventid
from participation
where memberid in
(select memberid from members as m where m.birthdate < '1-1-2001' and m.birthdate > '1-1-1994'));

--query 5
select *
from events
where eventid in
(select eventid from participation group by eventid having count(*)<3);

--query 6
select *
from members
where memberid in
(select memberid from participation group by memberid having count(*)>2);

update members
set member_ship='gold'
where memberid in
(select memberid from participation group by memberid having count(*)>2);

--query 7
delete from events
where startDate='2019-05-19' and 
categoryid in (select categoryid from categories where name='academic') and
eventid in 
(select o2.eventid
from organizators as o1 inner join organization as o2 on o1.organizatorid = o2.organizatorid
where o1.organizatorid in (select organizatorid from organizators where name='Dokuz Eylul University'));

--query 8
select me.e_mail
from members as me
where me.memberid in
(select pr.memberid
from participation as pr
group by pr.memberid order by count(*) desc limit 1);

--query 9
update events
set discountrate=25
where city like 'i%';

--query 10
delete from members
where memberid not in (select memberid from participation);










