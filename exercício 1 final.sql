create database warehouse;
use warehouse;

create table productlines(
productLine bigint not null auto_increment,
textDescription varchar(100),
htmlDescription varchar(100),
image text,
primary key(productLine)
);

create table products(
productCode bigint not null auto_increment,
productName varchar(100),
productLineFK bigint not null,
productScale float,
productVendor varchar(100),
productDescription varchar(100),
quantityInStock varchar(100),
buyPrice numeric(10,2),
MSRP numeric(10,2),
primary key(productCode),
foreign key(productLineFK) references productlines(productLine)
);

create table offices(
officeCode bigint not null auto_increment,
city varchar(100),
phone varchar(15),
addresLine1 varchar(100),
addresLine2 varchar(100),
state varchar(100),
country varchar(100),
postalCode varchar(10),
primary key(officeCode)
);

create table employees(
employeeNumber bigint not null auto_increment,
lastName varchar(100),
firstName varchar(100),
email varchar(100),
officeCodeFK bigint not null,
jobTitle varchar(100),
primary key(employeeNumber),
foreign key(officeCodeFK) references offices(officeCode)
);

create table customers(
customerNumber bigint not null auto_increment,
customerName varchar(100),
phone varchar(15),
addresLine1 varchar(100),
addresLine2 varchar(100),
city varchar(100),
state varchar(100),
postalCode varchar(10),
country varchar(100),
salesRepEmployeeNumberFK bigint not null,
creditLimit numeric(10,2),
primary key(customerNumber),
foreign key(salesRepEmployeeNumberFK) references employees(employeeNumber)
);

create table payments(
checkNumber bigint not null auto_increment,
customerNumberFK bigint not null,
paymentDate datetime default now(),
amount numeric(10,2),
primary key(checkNumber),
foreign key(customerNumberFK) references customers(customerNumber)
);

create table orders(
orderNumber bigint not null auto_increment,
orderDate datetime default now(),
requiredDate date,
shippedDate date,
status varchar(100),
comments varchar(100),
customerNumberFK bigint not null,
primary key(orderNumber),
foreign key(customerNumberFK) references customers(customerNumber)
);

create table orderdetails(
orderId bigint not null auto_increment,
orderNumberFK bigint not null,
productCodeFK bigint not null,
quantityOrdered bigint,
priceEach numeric(10,2),
orderLineNumber bigint,
primary key(orderId),
foreign key(orderNumberFK) references orders(orderNumber),
foreign key(productCodeFK) references products(productCode)
);

insert into productlines(textDescription, image) values
('milk derivatives',86216115),('breads',45624916);

insert into products (productName,ProductLineFK,productVendor,quantityInStock,buyPrice) values
('loaf bread',2,'Exe Breads',55,6.00),('whole milk',1,'Royal milk',90,4.55);

insert into offices(city,phone,state,country) values
('São Paulo',35796782,'São Paulo','Brazil'),('Campinas',32889637,'São Paulo','Brazil');

insert into employees(lastName,firstName,email,officeCodeFK,jobTitle) values
('Rodrigues','Caio','caiord@gmail.com',2,'accountant'),('Silva','Ruan','ruansilva@gmail.com',1,'secretary');

insert into customers(customerName,phone,city,state,country,salesRepEmployeeNumberFK,creditLimit) values 
('João Carlos','19994826537','Piracicaba','São Paulo','Brazil',1,1000.00),
('Maria dos Santos','19987889615','São Paulo','São Paulo','Brazil',2,750.00);

insert into payments(customerNumberFK,amount) values
(2,30.00),(1,50.00),(2,60.00);

insert into orders(requiredDate,shippedDate,customerNumberFK) values
('2023-01-08','2023-01-15',1),('2023-02-13','2023-02-18',2);

insert into orderdetails(orderNumberFK,productCodeFK,quantityOrdered,priceEach) values
(1,2,20,91.00),(2,1,20,120.00);

select * from orderdetails od
inner join orders o on od.orderNumberFK = o.orderNumber
inner join products p on od.productCodeFK = p.productCode
inner join customers c on o.customerNumberFK = c.customerNumber
inner join productlines pl on p.productLineFK = pl.productLine
inner join employees e on c.salesRepEmployeeNumberFK = e.employeeNumber
inner join offices oc on e.officeCodeFK = oc.officeCode;
