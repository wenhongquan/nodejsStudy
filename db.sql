-- function create
/* drop function if EXISTS first_func;
delimiter ;;
CREATE FUNCTION first_func(limits int)
RETURNS TINYINT
BEGIN
   RETURN 1;
END
;;
delimiter ;
select first_func(33); */


CREATE TABLE `user_info` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;


CREATE TABLE `type_info` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;


DROP PROCEDURE IF EXISTS selectuserbytype;
delimiter ;;
CREATE PROCEDURE selectuserbytype(limits int)
BEGIN
   DECLARE sqls varchar(1000) default '';
   DECLARE type_id int default 0;
   DECLARE done INT DEFAULT -1;
   DECLARE type_cursor CURSOR for select id from type_info;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
   open type_cursor;
   myloop:Loop
      fetch  type_cursor into type_id;
      IF done=1 THEN
         LEAVE myloop;
      END IF;

       set sqls= CONCAT(sqls,'(select * from user_info where type=',type_id,' limit ',limits,') union all ');


   end Loop;
   close type_cursor;

   set sqls = TRIM(TRAILING ' union all ' FROM sqls);


   set @sql = sqls;

   prepare stmt1 from @sql;
   execute stmt1;

END
;;
delimiter ;


call selectuserbytype(1)
