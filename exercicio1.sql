create database pecop;
use pecop;

create table productlines(
productLine bigint not null auto_increment,
textDescription varchar(100),
htmlDescription varchar(100),
image varchar(100),
primary key(productLine)
);

create table products(
productCode bigint not null auto_increment,
productName varchar(100),
productLineFK bigint not null,
productScale varchar(100),
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
phone bigint,
addresLine1 varchar(100),
addresLine2 varchar(100),
state varchar(100),
country varchar(100),
postalCode bigint,
territory varchar(100),
primary key(officeCode)
);

create table employees(
employeeNumber bigint not null auto_increment,
lastName varchar(100),
firstName varchar(100),
extension varchar(100),
email varchar(100),
officeCodeFK bigint not null,
reportsTo varchar(100),
jobTitle varchar(100),
primary key(employeeNumber),
foreign key(officeCodeFK) references offices(officeCode)
);

create table customers(
customerNumber bigint not null auto_increment,
customerName varchar(100),
contactLastName varchar(100),
contactFirstName varchar(100),
phone bigint,
addresLine1 varchar(100),
addresLine2 varchar(100),
city varchar(100),
state varchar(100),
postalCode bigint,
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
requiredDate datetime,
shippedDdate datetime,
status varchar(100),
comments varchar(100),
customerNumberFK bigint not null,
primary key(orderNumber),
foreign key(customerNumberFK) references customers(customerNumber)
);

create table orderdetails(
orderId bigint not null auto_increment,





);
