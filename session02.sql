create database qlbh;
use qlbh;

create table Catalog(
id int auto_increment primary key,
name varchar(100) not null,
status bit  default 1
);
-- thêm mới dữ liệu 
insert into Catalog (name) values
("Quần"),
("Áo"),
("Trang sức"),
("Giày"),
("Mũ"),
("Túi xách"),
("Phụ kiện"), 
("Kính"), 
("Đồng hồ");

-- chỉnh sửa dữ liệu
update Catalog set name = "Giày dép" where id = 4 ;
-- xóa dữ liệu 
delete from catalog where id = 7;

-- truy vấn dữ liệu cơ bản
select id as `Mã danh mục`, name as `tên danh mục` from catalog as c where c.name = "Quần 1 ";

create table Product(
id int auto_increment primary key,
name varchar(200) not null,
price double check(price > 0),
description text ,
catalogId int not null,
status bit,
foreign key (catalogId) references Catalog(id)
);
insert into Product(name,price,description,catalogId,status) values
("Áo ba lỗ nam ",100,"",2,1),
("Quần jean nam ",150,"",1,1),
("Vòng cổ bạc",200,"",3,1),
("Kính mắt Anna ",120,"",8,1),
("Mũ lưỡi trai",70,"",5,1),
("Giày nike ",450,"",4,1),
("Đồng hồ Rolex",25000,"",9,1),
("Túi alligator",1000,"",2,1),
("Áo dài",500,"",2,1),
("Ốp điện thoại ",10,"",7,1);

create table Role(
id int auto_increment primary key,
rolename varchar(50) not null unique
);
create table User(
id int auto_increment primary key,
fullname varchar(100),
username varchar(100) not null unique,
password varchar(255) not null,
status bit default 1
);

create table Address(
id int auto_increment primary key,
fullname varchar(150) not null,
phoneNumber varchar(13) not null,
address varchar(255) not null,
status bit default 0,
userid int not null,
foreign key(userid) references User(id)
);

create table user_role (
id int auto_increment primary key, 
userid int not null,
roleId int not null,
foreign key(userid) references User(id),
foreign key(roleId) references Role(id)
);
create table Cart(
id int auto_increment primary key,
userid int not null unique,
foreign key(userid) references User(id)
);
create table CartDetail(
id int auto_increment primary key,
cartid int not null,
productId int not null,
quantity int check(quantity > 0),
foreign key(cartid) references Cart(id),
foreign key(productid) references Product(id)
);
create table Orders(
id int auto_increment primary key,
userid int not null,
total double,
dateCreate datetime default(now()),
addressid int not null ,
foreign key(addressid) references Address(id),
foreign key(userid) references User(id)
);
create table OrderDetail(
id int auto_increment primary key,
orderid int not null,
productId int not null,
price double check(price > 0), 
quantity int check(quantity > 0),
foreign key(orderid) references Orders(id),
foreign key(productid) references Product(id)
);

-- Tạo 3 tài khoản user , 1 tài khoản admin

insert into role (rolename) values 
("user"),("admin");
insert into user(fullname,username,password) values
("Hieu Ca Mau","hieu","123"),
("Khanh sky","Khanh","123"),
("Long ruoi","Long","123"),
("","admin","admin");
insert into user_role(userid,roleId) values
(1,1),(2,1),(3,1),(4,2),(4,1);
-- Với mỗi tài khoản user tạo 2 địa chỉ giâo hàng   
insert into address(fullname,phoneNumber,address,userid) values
("binh 1 nang","01234457","ha noi",1),
("binh 2 nang","012344588","ha noi",1),
("binh 3 nang","012344579","ha noi",2),
("binh 4 nang","012344599","ha noi",2),
("binh 5 nang","0123445798","ha noi",3),
("binh 6  nang","0123445990","ha noi",3)
;
-- tạo 3 giỏ hàng , môi giỏ có ít nhất 2 sản phẩm , (số lương >5)
insert into cart(userid) values
(1),(2),(3);

insert into cartdetail(cartid,productid,quantity) values
(1,1,6),(1,2,6),
(2,1,6),(2,2,6),
(3,1,6),(3,2,6);
-- tạo 5 hóa đơn bất kì cho các tai khỏan user , mỗi hóa đơn thì có ít nhất 2 sp (số lượng  >5)
insert into Orders(userid,total,addressid) values(2,0,3),(2,0,4),(3,0,5),(3,0,5),(3,0,6);
insert into orderdetail(orderid,productId,price,quantity) values
(1,1,100,10),(1,3,120,10),
(2,5,120,10),(2,8,150,10),
(3,1,100,10),(3,6,200,10),
(4,5,140,10),(4,6,200,10),
(5,5,140,10),(5,3,120,10);
update orders set total = 2200 where id=1;
update orders set total = 2700 where id=2;
update orders set total = 3000 where id=3;
update orders set total = 3400 where id=4;
update orders set total = 3600 where id=5;





