CREATE DATABASE hotel;

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


-- -----------------------------------------------------------------create tables -------------------------------------------------------------------------
create table room_place(
room_place_id int AUTO_INCREMENT ,
room_building int,
room_floor int,
primary key(room_place_id)
);

-- הוספת בניינים וקומות
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
select *from room;

insert into room(room_status_id,room_place_id,room_type_id,room_bed_num,room_day_price,room_change_status_date)
values(1,1,1,2,300,curdate()),(1,2,1,2,300,curdate()),(1,3,1,2,300,curdate());

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
select *from worker_clean_room;

insert into worker_clean_room(worker_id,room_id ,clean_date,clean_start_time)
values(2,1,curdate(),curtime());

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





-- queries

-- ---------------------------------------------------------------------------------------------------------------
-- 1 הצגת כל החדרים ומצבם
select r.room_id room_number, rs.room_status_name status
 from room r 
 inner join room_status rs
 on
 r.room_status_id=rs.room_status_id 
 order by room_id;
 
 
 -- ---------------------------------------------------------------------------------------------------------------
-- 2 רשימת 10 החדרים שהוזמנו הכי הרבה
select room_id, COUNT(*)
from orders
group by room_id order by  room_id asc limit 10;

select *from orders;
-- ---------------------------------------------------------------------------------------------------------------
-- 3 הצגת כל ההזמנות בשבועיים האחרונים
SELECT * FROM
 orders 
 WHERE  DATEDIFF( CURDATE(), order_create_date ) <= 14 ORDER BY order_create_date DESC;

-- ---------------------------------------------------------------------------------------------------------------
-- 4 הצגת העובד שניקה הכי הרבה חדרים
select w.worker_id,w.worker_fname,w.worker_lname, count(*)
from worker_clean_room wcr
inner join worker w
on wcr.worker_id=w.worker_id
group by worker_id
order by count(*) desc limit 1 ;

select * from worker;
-- ---------------------------------------------------------------------------------------------------------------
-- 5 הצגת הזמנות פעילות
select o.order_id order_number,c.customer_fname,c.customer_lname,o.order_start_date,o.order_end_date,order_total_price  from orders o
inner join customer c
on o.customer_id=c.customer_id
where order_start_date <=curdate() and curdate()<= order_end_date ; 

-- insert order to check that
insert into orders(room_id ,worker_id ,customer_id,order_create_date,order_start_date,order_end_date ,order_total_price)
select 8,7, 6,'2021-06-10','2021-06-13','2021-06-16',room_day_price*(1+datediff('2021-06-16','2021-06-13')) from room where room_id=8;

-- ---------------------------------------------------------------------------------------------------------------
-- 6 הצגת לקוחות חוזרים- יותר מהזמנה אחת בתאירכים שונים

select sub.customer_id,sub.customer_fname,sub.customer_lname, count(*)
from  (
select c.customer_id,c.customer_fname,c.customer_lname
from orders o
inner join customer c
on o.customer_id=c.customer_id
group by customer_id , order_create_date
) as sub
group by customer_id
having count(*)>1;


--  הכנסה לבדיקה
insert into orders(room_id ,worker_id ,customer_id,order_create_date,order_start_date,order_end_date ,order_total_price)
select 1,6, 1,'2020-07-01','2020-09-01','2020-09-05',room_day_price*(1+datediff('2020-09-05','2020-09-01')) from room where room_id=1;
-- 


-- ---------------------------------------------------------------------------------------------------------------
-- 7 הצגת הכנסות לפי חודש

SELECT YEAR(order_start_date) as Year,
         MONTH(order_start_date) as Month,
         SUM(order_total_price) AS TotaIncome_for_this_month_in_the_year
    FROM orders
GROUP BY YEAR(order_start_date), MONTH(order_start_date)
ORDER BY YEAR(order_start_date), MONTH(order_start_date);


-- insert to check
insert into orders(room_id ,worker_id ,customer_id,order_create_date,order_start_date,order_end_date ,order_total_price)
select 1,7, 1,'2020-06-12','2023-06-13','2023-06-15',room_day_price*(1+datediff('2023-06-15','2023-06-13')) from room where room_id=1;
select * from orders;

insert into orders(room_id ,worker_id ,customer_id,order_create_date,order_start_date,order_end_date ,order_total_price)
select 1,7, 2,'2020-06-12','2023-06-16','2023-06-18',room_day_price*(1+datediff('2023-06-18','2023-06-16')) from room where room_id=1;
select * from orders;

insert into orders(room_id ,worker_id ,customer_id,order_create_date,order_start_date,order_end_date ,order_total_price)
select 2,8, 3,'2020-06-12','2023-06-13','2023-06-15',room_day_price*(1+datediff('2023-06-15','2023-06-13')) from room where room_id=2;
select * from orders;

insert into orders(room_id ,worker_id ,customer_id,order_create_date,order_start_date,order_end_date ,order_total_price)
select 2,8, 4,'2020-06-12','2023-06-16','2023-06-18',room_day_price*(1+datediff('2023-06-18','2023-06-16')) from room where room_id=2;
select * from orders;

delete from orders
where order_id=31 or order_id=32 or order_id=33;

select * from orders;

-- ---------------------------------------------------------------------------------------------------------------

-- 1 function 
set global log_bin_trust_function_creators=1;

DELIMITER $$
create FUNCTION get_status_room(in_room_number int) returns varchar(100)
begin
declare answer_status varchar(60) default null;
select room_status_name 
Into answer_status 
from room r
inner join room_status rs
on 
	r.room_status_id=rs.room_status_id 
where
	room_id=in_room_number;
    return answer_status;
    
    END$$
DELIMITER ;

-- הרצת פונקציה
select get_status_room(1);
-- מחיקת פונקציה
drop function get_status_room;

-- make update status for room number 1 to check if we get right answer-yes!
update room
set room_status_id=1
where room_id=1;

-- ---------------------------------------------------------------------------------------------------------------
-- procedure 1

DELIMITER $$
create procedure update_about_room_cleaning( IN in_room_number int,IN in_worker_id int, IN in_action varchar(20) )
begin
declare statusResult int default 0;
select room_status_id 
Into statusResult from
room where room_id=in_room_number;

IF(statusResult=4 and in_action='end') THEN
-- status 4= cleaning in progress
	-- 1
	update worker_clean_room 
	set clean_end_time=now() where room_id=in_room_number and worker_id=in_worker_id and clean_date=curdate();
	-- 2
	update room 
	set room_change_status_date=current_timestamp(),room_status_id=1 where room_id=in_room_number ; 

ELSEIF(statusResult=3 and in_action='start') 
-- free waiting for cleaning
THEN
-- 1
	insert into worker_clean_room(room_id,worker_id,clean_date,clean_start_time)
	values(in_room_number,in_worker_id,curdate(),curtime());
	-- 2 שינוי סטטוס לבניקוי וגם עדכון זמן השינוי סטטוס לעכשיו
	update room 
	set room_change_status_date=current_timestamp(),room_status_id=4 where room_id=in_room_number ; 
END IF;
    end $$
DELIMITER ;

-- check
drop procedure update_about_room_cleaning;
select * from room;

update room
set room_status_id=3 where room_id=1;

call update_about_room_cleaning(1,1,'start');
call update_about_room_cleaning(1,1,'end');

select * from room;

delete from worker_clean_room
where worker_id=1 and room_id=1;
select * from worker_clean_room;

select * from room;
desc room;


-- ---------------------------------------------------------------------------

-- 2 procedura
-- נשלח מספר הזמנה
-- התוצאה עדכון סטטוס של החדר שעליו בוצעה הזמנה להיום
DELIMITER $$
create procedure update_room_status_when_order_start(IN in_order_number int)
begin
declare dateResult date default '2000-00-00';
declare roomResult int default 0;

select order_start_date,room_id 
Into dateResult,roomResult from orders where order_id=in_order_number;

	IF (dateResult<=curdate() and curdate()<=dateResult)
	THEN
		update room
		set room_status_id = 2,room_change_status_date=current_timestamp()
        where room_id = roomResult;
        
	end if;
    end $$
DELIMITER ;

drop procedure update_room_status_when_order_start;
desc orders;
desc room;

-- check
select*from orders;

insert into orders(room_id ,worker_id ,customer_id,order_create_date,order_start_date,order_end_date ,order_total_price)
select 1,6, 1,'2021-06-14','2021-06-15','2021-06-17',room_day_price*(1+datediff('2021-06-17','2021-06-15')) from room where room_id=1;

insert into orders(room_id ,worker_id ,customer_id,order_create_date,order_start_date,order_end_date ,order_total_price)
select 2,6, 2,'2021-06-13','2021-06-15','2021-06-17',room_day_price*(1+datediff('2021-06-17','2021-06-15')) from room where room_id=2;

select * from room;
select* from orders;
call update_room_status_when_order_start(29);
call update_room_status_when_order_start(30);


select * from room_status;