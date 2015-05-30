2015.05.28

1.create database ebay_uk;
2.use ebay_uk;
3.create table listing
(
id int not null primary key auto_increment,
sellerid varchar(30),
location varchar(30),
itemnumber char(12),
category varchar(50),
title varchar(85),
price varchar(10),
shipping varchar(7),
sales varchar(8),
listing_url varchar(250)
)charset utf8;


create table salesdetails
(
id int not null primary key auto_increment,
itemnumber char(12),
price varchar(10),
quantity varchar(3),
shoptime date
)charset utf8;


 ��ѯ�����۶��150�����itemnumber
 1.�Ȳ�ѯ ÿ��itemnumber�굥�ڵ���������
 select *,sum(quantity) from salesdetails group by itemnumber;
 2.�ٲ�ѯ ÿ��itemnumber�굥�����ڴ���2015.04.20��item��
 select *,sum(quantity) from salesdetails group by itemnumber having shoptime>'2015-04-20';
  select *,sum(quantity) from salesdetails where shoptime >'2015-04-20' group by itemnumber; 
  3.������ͼ
  create algorithm=temptable view tempdetails as select * from salesdetails where shoptime>'2015-04-20';
  4 ��ѯ�����۶� 
  select *,sum(quantity)*price from salesdetails group by itemnumber having shoptime>'2015-04-20';
  5.��ѯ�����۶����150�����item
  select tempdetails.* from 
  (
select *,sum(quantity)*price as volume ,sum(quantity)as total from salesdetails group by itemnumber having shoptime>'2015-04-20'
  ) as tempdetails 
  where tempdetails.volume>150;
  
  6.��listing�����ϲ�ѯ�����item����ϸ��Ϣ
  select * from
 (
 select tempdetails.* from 
 (
select *,sum(quantity)*price as volume ,sum(quantity)as total from salesdetails where shoptime>'2015-04-20'group by itemnumber 
  ) as tempdetails 
  where tempdetails.volume>150
 ) as finalldetails
 left join listing on finalldetails.itemnumber=listing.itemnumber;
 
