CREATE DATABASE hotel;

-- -----------------------------------------------------------------create hotel datebase -------------------------------------------------------------------------
create table room_place(
room_place_id int AUTO_INCREMENT ,
room_building int,
room_floor int,
primary key(room_place_id)
);

insert into room_place(room_building,room_floor)
values('1','2'),('1','3'),('1','4'),('1','5'),('2','1'),('2','2'),('2','3'),('2','4'),('2','5');

select *from room_place;
-- ---------------------------------------------------------------------------------------------------

create table room_type(
room_type_id int AUTO_INCREMENT,
room_type_name varchar(40),
primary key(room_type_id)
);

-- הוספת סוגי חדרים
insert into room_type(room_type_name)
values('regular'),('suite'),('president suit');

select *from room_type;

-- ---------------------------------------------------------------------------------------------------
create table room_status(
room_status_id int AUTO_INCREMENT,
room_status_name varchar(40),
primary key(room_status_id)
);

insert into room_status(room_status_name)
values('free'),('occupied'),('free waiting for cleaning '),('cleaning in progress');

select *from room_status;

-- ---------------------------------------------------------------------------------------------------
create table room(
room_id int AUTO_INCREMENT,
room_place_id int,
room_type_id int,
room_status_id  int,
room_change_status_date datetime,
room_bed_num int,
room_day_price int,
primary key(room_id),
FOREIGN KEY (room_type_id) REFERENCES room_type(room_type_id),
FOREIGN KEY (room_status_id) REFERENCES room_status(room_status_id),
FOREIGN KEY (room_place_id) REFERENCES room_place(room_place_id)
);

insert into room(room_status_id,room_place_id,room_type_id,room_bed_num,room_day_price,room_change_status_date)
values(1,1,1,1,300,current_timestamp()),(1,2,1,2,600,curdate()),(1,3,1,3,900,current_timestamp()),(1,4,2,1,400,current_timestamp()),(1,5,2,2,800,
current_timestamp()),(1,6,2,3,1200,current_timestamp()),(1,7,3,1,500,current_timestamp()),(1,8,3,2,1000,current_timestamp()),(1,9,3,3,1500,current_timestamp()),(1,10,3,3,1500,current_timestamp());

insert into room(room_status_id,room_place_id,room_type_id,room_bed_num,room_day_price,room_change_status_date)
values(1,1,1,2,300,curdate()),(1,2,1,2,300,curdate()),(1,3,1,2,300,curdate());

select *from room;

-- ---------------------------------------------------------------------------------------------------

create table state(
state_id int AUTO_INCREMENT,
state_name varchar(40),
primary key(state_id)
);

insert into state(state_name)
values('Israel'),('Greece'),('France'),('Russia'),('China'),('Spain'),('Poland'),('Turkey'),('Thiland'),('Italy');

select *from state;

-- ---------------------------------------------------------------------------------------------------
create table city(
city_id int AUTO_INCREMENT,
city_name varchar(40),
primary key(city_id)
);

insert into city(city_name)
values('Tel Aviv'),('Lod'),('Ramat Gan'),('Hod Hasharon'),('Rehovot'),('Kfar Saba'),('Oranit'),('Gdera'),('Dimona'),('Eilat');

select *from city;

-- ---------------------------------------------------------------------------------------------------
create table street(
street_id int AUTO_INCREMENT,
street_name varchar(40),
primary key(street_id)
);

insert into street(street_name)
values('Hacohanim'),('Weizman'),('Herzel'),('Sokolov'),('Shabtay'),('Anna frank'),('Munir'),('Dror'),('Rakefet'),('Calanit');

select *from street;

-- ---------------------------------------------------------------------------------------------------
create table address(
address_id int AUTO_INCREMENT,
state_id int ,
city_id int ,
street_id int ,
primary key(address_id),
FOREIGN KEY (state_id) REFERENCES state(state_id),
FOREIGN KEY (city_id) REFERENCES city(city_id),
FOREIGN KEY (street_id) REFERENCES street(street_id)
);

insert into address(state_id,city_id,street_id)
values(1,1,1),(1,1,2),(1,1,3),(1,1,4),(1,1,5),(1,1,6),(1,1,7),(1,1,8),(1,1,9),(1,1,10);

select *from address;

-- ---------------------------------------------------------------------------------------------------

create table worker_role(
worker_role_id int AUTO_INCREMENT,
worker_role_name varchar(40),
primary key(worker_role_id)
);
insert into worker_role(worker_role_name)
values('cleaner'),('Receptionist');

select *from worker_role;

---------------------------------------------------------------------------------------------------
create table worker(
worker_id int AUTO_INCREMENT,
worker_role_id int,
worker_fname varchar(40),
worker_lname varchar(40),
worker_phone varchar(40),
primary key(worker_id),
FOREIGN KEY (worker_role_id) REFERENCES worker_role(worker_role_id)
);

insert into worker(worker_role_id,worker_fname,worker_lname,worker_phone)
values('1','shani','levy','0526786654'),('1','shir','cohen','0526786111'),('1','shosh','agami','0525556654'),('1','sol','kirel','0528886654'),('1','samira','abed','0526796954'),
('2','noa','kirel','0526786111'),('2','noam','cohen','0526786222'),('2','nurit','paz','0525556333'),('2','nili','shofar','0528886444'),('2','noy','peled','0526796555');

select *from worker;

-- ---------------------------------------------------------------------------------------------------

create table worker_address(
worker_id int ,
address_id int,
house_number int,
primary key(worker_id),
FOREIGN KEY (worker_id) REFERENCES worker(worker_id),
FOREIGN KEY (address_id) REFERENCES address(address_id)
);

insert into worker_address(worker_id,address_id ,house_number)
values(1,1,1),(2,2,2),(3,3,3),(4,4,4),(5,5,5),(6,6,6),(7,7,7),(8,8,8),(9,9,9),(10,10,10);

select *from worker_address;

-- ---------------------------------------------------------------------------------------------------
create table worker_clean_room(
worker_id int,
room_id int,
clean_date  date,
clean_start_time time,
clean_end_time time,
primary key(worker_id,room_id,clean_date),
FOREIGN KEY (worker_id ) REFERENCES worker(worker_id),
FOREIGN KEY (room_id ) REFERENCES room(room_id)
);

insert into worker_clean_room(worker_id,room_id ,clean_date,clean_start_time,clean_end_time)
values(1,1,curdate(),curtime()),(1,2,curdate(),curtime()),(2,3,curdate(),curtime()),(2,4,curdate(),curtime()),(3,5,curdate(),curtime()),(3,6,curdate(),curtime()),(4,7,curdate(),curtime()),(4,8,curdate(),curtime()),(5,9,curdate(),curtime()),(5,10,curdate(),curtime());

insert into worker_clean_room(worker_id,room_id ,clean_date,clean_start_time)
values(2,1,curdate(),curtime());

select *from worker_clean_room;

-- ---------------------------------------------------------------------------------------------------

create table customer(
customer_id int AUTO_INCREMENT,
customer_fname varchar(40),
customer_lname varchar(40),
customer_phone varchar(40),
primary key(customer_id)
);

insert into customer(customer_fname,customer_lname ,customer_phone)
values('adi','peled', '0526861776'),('karina','nosenko', '0545491128'),('noa','abodi', '0526861111'),('noy','levy', '0526861224'),('omer','adam', '0526864444'),('eyal','golan', '0526869999'),
('shira','tomer', '0525559999'),('dana','gil', '0526863456'),('berry','cohen', '0526763378'),('shimon','perey', '0543637764');

select *from customer;

-- ---------------------------------------------------------------------------------------------------
create table customer_address(
customer_id int ,
address_id int,
house_number int,
primary key(customer_id),
FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
FOREIGN KEY (address_id) REFERENCES address(address_id)
);

insert into customer_address(customer_id ,address_id ,house_number)
values(1,1, 11),(2,2, 20),(3,3, 30),(4,4, 40),(5,5, 50),
(6,6, 60),(7,7, 70),(8,8, 80),(9,9, 90),(10,10, 100);

select *from customer_address;

-- ---------------------------------------------------------------------------------------------------

create table orders(
order_id int AUTO_INCREMENT,
room_id int,
worker_id int,
customer_id int,
order_create_date date,
order_start_date date,
order_end_date date,
-- order_total_price int not null default (calculate_price(room_id,order_start_date,order_end_date)),
order_total_price int,
primary key(order_id,room_id,worker_id,customer_id),
FOREIGN KEY (room_id ) REFERENCES room(room_id),
FOREIGN KEY (worker_id ) REFERENCES worker(worker_id),
FOREIGN KEY (customer_id ) REFERENCES customer(customer_id)
);


insert into orders(room_id ,worker_id ,customer_id,order_create_date,order_start_date,order_end_date ,order_total_price)
select 1,6, 1,curdate(),'2021-08-01','2021-08-02',room_day_price*(1+datediff('2021-08-02','2021-08-01')) from room where room_id=1;
-- 
insert into orders(room_id ,worker_id ,customer_id,order_create_date,order_start_date,order_end_date ,order_total_price)
select 2,6, 2,curdate(),'2021-08-01','2021-08-03',room_day_price*(1+datediff('2021-08-03','2021-08-01')) from room where room_id=2;

insert into orders(room_id ,worker_id ,customer_id,order_create_date,order_start_date,order_end_date ,order_total_price)
select 3,7, 3,curdate(),'2021-08-01','2021-08-04',room_day_price*(1+datediff('2021-08-04','2021-08-01')) from room where room_id=3;

insert into orders(room_id ,worker_id ,customer_id,order_create_date,order_start_date,order_end_date ,order_total_price)
select 4,7, 4,curdate(),'2021-08-01','2021-08-05',room_day_price*(1+datediff('2021-08-05','2021-08-01')) from room where room_id=4;

insert into orders(room_id ,worker_id ,customer_id,order_create_date,order_start_date,order_end_date ,order_total_price)
select 5,8, 5,curdate(),'2021-08-01','2021-08-06',room_day_price*(1+datediff('2021-08-06','2021-08-01')) from room where room_id=5;

insert into orders(room_id ,worker_id ,customer_id,order_create_date,order_start_date,order_end_date ,order_total_price)
select 6,8, 6,curdate(),'2021-08-01','2021-08-07',room_day_price*(1+datediff('2021-08-07','2021-08-01')) from room where room_id=6;

insert into orders(room_id ,worker_id ,customer_id,order_create_date,order_start_date,order_end_date ,order_total_price)
select 7,9, 7,curdate(),'2021-08-01','2021-08-08',room_day_price*(1+datediff('2021-08-08','2021-08-01')) from room where room_id=7;

insert into orders(room_id ,worker_id ,customer_id,order_create_date,order_start_date,order_end_date ,order_total_price)
select 8,9, 8,curdate(),'2021-08-01','2021-08-09',room_day_price*(1+datediff('2021-08-09','2021-08-01')) from room where room_id=8;

insert into orders(room_id ,worker_id ,customer_id,order_create_date,order_start_date,order_end_date ,order_total_price)
select 9,10, 9,curdate(),'2021-08-01','2021-08-10',room_day_price*(1+datediff('2021-08-10','2021-08-01')) from room where room_id=9;

insert into orders(room_id ,worker_id ,customer_id,order_create_date,order_start_date,order_end_date ,order_total_price)
select 10,10, 10,curdate(),'2021-08-01','2021-08-11',room_day_price*(1+datediff('2021-08-11','2021-08-01')) from room where room_id=10;


insert into orders(room_id ,worker_id ,customer_id,order_create_date,order_start_date,order_end_date ,order_total_price)
select 10,6, 5,curdate(),'2021-08-01','2021-08-20',room_day_price*(1+datediff('2021-08-20','2021-08-01')) from room where room_id=10;

insert into orders(room_id ,worker_id ,customer_id,order_create_date,order_start_date,order_end_date ,order_total_price)
select 9,7, 6,curdate(),'2021-08-7','2021-08-21',room_day_price*(1+datediff('2021-08-7','2021-08-01')) from room where room_id=9;

insert into orders(room_id ,worker_id ,customer_id,order_create_date,order_start_date,order_end_date ,order_total_price)
select 1,6, 1,curdate(),'2021-11-01','2021-11-02',room_day_price*(1+datediff('2021-11-02','2021-11-01')) from room where room_id=1;
-- 
insert into orders(room_id ,worker_id ,customer_id,order_create_date,order_start_date,order_end_date ,order_total_price)
select 2,6, 2,curdate(),'2021-11-01','2021-11-03',room_day_price*(1+datediff('2021-11-03','2021-11-01')) from room where room_id=2;

insert into orders(room_id ,worker_id ,customer_id,order_create_date,order_start_date,order_end_date ,order_total_price)
select 3,7, 3,curdate(),'2021-11-01','2021-11-04',room_day_price*(1+datediff('2021-11-04','2021-11-01')) from room where room_id=3;

insert into orders(room_id ,worker_id ,customer_id,order_create_date,order_start_date,order_end_date ,order_total_price)
select 4,7, 4,curdate(),'2021-11-01','2021-11-05',room_day_price*(1+datediff('2021-11-05','2021-11-01')) from room where room_id=4;

insert into orders(room_id ,worker_id ,customer_id,order_create_date,order_start_date,order_end_date ,order_total_price)
select 5,8, 5,curdate(),'2021-11-01','2021-11-06',room_day_price*(1+datediff('2021-11-06','2021-11-01')) from room where room_id=5;

insert into orders(room_id ,worker_id ,customer_id,order_create_date,order_start_date,order_end_date ,order_total_price)
select 6,8, 6,curdate(),'2021-11-01','2021-11-07',room_day_price*(1+datediff('2021-11-07','2021-11-01')) from room where room_id=6;

insert into orders(room_id ,worker_id ,customer_id,order_create_date,order_start_date,order_end_date ,order_total_price)
select 8,9, 7,curdate(),'2021-11-01','2021-11-08',room_day_price*(1+datediff('2021-11-08','2021-11-01')) from room where room_id=8;

insert into orders(room_id ,worker_id ,customer_id,order_create_date,order_start_date,order_end_date ,order_total_price)
select 8,9, 7,curdate(),'2021-11-01','2021-11-08',room_day_price*(1+datediff('2021-11-08','2021-11-01')) from room where room_id=8;

insert into orders(room_id ,worker_id ,customer_id,order_create_date,order_start_date,order_end_date ,order_total_price)
select 8,7, 6,'2020-06-12','2020-06-13','2020-06-15',room_day_price*(1+datediff('2020-06-15','2020-06-13')) from room where room_id=8;

select * from orders;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------

-- tables
select * from orders;
select *from customer;
select *from customer_address;
select * from room;
select * from room_place;
select * from room_type;
select * from room_status;
select* from worker_clean_room;
select * from worker;
select *from worker_role;
select * from worker_address;
select * from address;
select * from state;
select * from city;
select * from street;


