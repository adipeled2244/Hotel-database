
-- queries

-- 1 הצגת כל החדרים ומצבם
select r.room_id room_number, rs.room_status_name status
 from room r 
 inner join room_status rs
 on
 r.room_status_id=rs.room_status_id 
 order by room_id;

-- 2
select room_id, COUNT(*)
from orders
group by room_id order by  room_id asc limit 10;

-- 3 הצגת כל ההזמנות בשבועיים האחרונים
SELECT * FROM
 orders 
 WHERE  DATEDIFF( CURDATE(), order_create_date ) <= 14 ORDER BY order_create_date DESC;
 
-- 4 הצגת העובד שניקה הכי הרבה חדרים
select w.worker_id,w.worker_fname,w.worker_lname, count(*)
from worker_clean_room wcr
inner join worker w
on wcr.worker_id=w.worker_id
group by worker_id
order by count(*) desc limit 1 ;

-- 5 הצגת הזמנות פעילות
select o.order_id order_number,c.customer_fname,c.customer_lname,o.order_start_date,o.order_end_date,order_total_price  from orders o
inner join customer c
on o.customer_id=c.customer_id
where order_start_date <=curdate() and curdate()<= order_end_date ; 

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

-- 7

-- 7 הצגת הכנסות לפי חודש

SELECT YEAR(order_start_date) as Year,
         MONTH(order_start_date) as Month,
         SUM(order_total_price) AS TotaIncome_for_this_month_in_the_year
    FROM orders
GROUP BY YEAR(order_start_date), MONTH(order_start_date)
ORDER BY YEAR(order_start_date), MONTH(order_start_date);



-- -------------------------------------------------------------------------procedure  

-- 1 עדכון תחילת סיום ניקוי חדר

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

-- -------------------------------------------------------------------------------function---------------------------------------------

-- 1 החזרת מצב החדר המבוקש
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