create database food_oms_db;
use food_oms_db;

-- DDL
create table categories (id int auto_increment not null, name varchar(50) default null unique, primary key(id));

create table items (id int auto_increment not null, name varchar(50) default null, price decimal(10,2) default 0, primary key (id));

create table item_categories (item_id int not null, category_id int not null, foreign key (item_id) references items(id), foreign key (category_id) references categories(id));

create table users (id int not null auto_increment, username varchar(50) unique, password char(32) not null, primary key (id));

create table user_informations (user_id int not null, name varchar(50), phone varchar(15) unique, foreign key (user_id) references users(id));

create table orders (id int auto_increment not null, customer_id int not null, order_date_time datetime not null default now(), primary key (id), foreign key (customer_id) references user_informations(user_id));
 
create table order_details (item_id int not null, order_id int not null, quantity int default 1, foreign key (item_id) references items(id), foreign key (order_id) references orders(id));

-- DML - Insert 
insert into users (username, password) values 
('budiawan_ganteng', md5('budiawan_ganteng')),
('mary_jones_cantik', md5('mary_jones_cantik')),
('deborah_cantik', md5('deborah_cantik')),
('gen_g_keren', md5('gen_g_keren')),
('go_academy_keren', md5('go_academy_keren'));

insert into user_informations (user_id, name, phone) values 
(1, 'Budiawan', '+6212345678'),
(2, 'Mary Jones', '+6287654321'),
(3, 'Deborah', '+6289753214'),
(4, 'Generation Girl', '+6212345676'),
(5, 'Go Academy', '+62878909878');

insert into items (name, price) values 
('Nasi Goreng Gila', 20000),
('Ice Water', 2000),
('Spaghetti', 40000),
('Green Tea Latte', 18000),
('Vanilla Ice Cream', 13000),
('Cordon Bleu', 36000),
('French Fries', 20000),
('Mango Juice', 15000),
('Orange Juice', 15000),
('Es Podeng', 15000),
('Sushi', 100000),
('Ice Cream', 20000),
('Pancake', 40000),
('Steak', 80000),
('Dimsum', 13000),
('Ayam Ganesha', 36000),
('Bakso', 20000),
('Donat Bakar', 15000),
('Bread', 15000);

insert into categories (name) values ('Main Dish'), ('Beverage'), ('Dessert');

insert into item_categories (item_id, category_id) values 
(1, 1),
(2, 2),
(3, 1),
(4, 2),
(5, 3),
(6, 1),
(7, 1);

insert into orders (customer_id, order_date_time) values 
(1, now()),
(2, now()),
(1, now() - interval 1 day),
(2, now() - interval 1 day),
(2, now() - interval 2 day);

insert into order_details (order_id, item_id, quantity) values 
(1, 1, 2),
(1, 2 ,2),
(2, 3, 5),
(2, 3, 2),
(2, 2, 3),
(3, 5, 1),
(4, 10, 3),
(5, 6, 1),
(5, 7, 2);

-- DML - Select
select order_id, order_date, user_informations.name as customer_name, phone as customer_phone, total, items_bought from user_informations join orders on user_id = customer_id join (select order_id, date(order_date_time) as order_date, sum(price * quantity) as total, group_concat(distinct name separator ', ') as items_bought from orders join order_details on orders.id = order_id join items on item_id = items.id group by order_id) as _ on order_id = orders.id order by order_id asc;