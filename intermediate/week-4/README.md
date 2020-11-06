# Week-4 Homework
This folder is used for the homework and exercise in week-3.

## Project Structure
The structure of the project is explained in below. The tag `homework` means the file is the homeworks files.
```
|_ controllers
| |_ item_controller.rb
| |_ category_controller.rb
| |_ application_controller.rb
|_ db
| |_ db.sql           
| |_ mysql_connector.rb  
|_ models
| |_ category.rb
| |_ item_category.rb
| |_ item.rb
|_ public
| |_ img
| |_ stylesheets
| | |_ index.css
|_ snapshots      
|_ views
| |_ categories
| | |_ edit.erb  
| | |_ list_items.erb
| | |_ list.erb
| | |_ new.erb    
| |_ items 
| | |_ detail.erb  
| | |_ edit.erb
| | |_ lists.erb
| | |_ new.erb     
|_ main.rb            
|_ README.md
```

## Instructions
1. Install the needed gems.
```
gem install sinatra
gem install mysql2
```
2. Login to mysql using the username and password. Copy and paste `db.sql` contents to mysql.
3. Export the environment variables in terminal. Notes: DB_HOST can use `localhost` value for your personal environment.
```
export DB_HOST=<your_host>          
export DB_NAME=food_oms_db
export DB_USERNAME=<your_username>
export DB_PASSWORD=<your_password>
```
4. Run `ruby main.rb`. To see the web enter `localhost:4567` in your browser.

## Snapshots
Homepage\
<img src="snapshots/home.png" width=1000>

List Items\
<img src="snapshots/items_list.png" width=1000>

After delete items of <b>Nasi Goreng Gila</b>\
<img src="snapshots/items_delete.png" width=1000>

Edit form for item <b>Ice water</b>\
<img src="snapshots/items_edit_form.png" width=1000>

After edit information of <b>Ice Water</b>\
<img src="snapshots/items_edit.png" width=1000>

Information details of <b>Ice Water</b>\
<img src="snapshots/items_detail.png" width=1000>

New form of item <b>Ultimate Cheese Pizza</b>\
<img src="snapshots/items_new_form.png" width=1000>

After new information of <b>Ultimate Cheese Pizza</b>\
<img src="snapshots/items_new.png" width=1000>

List categories\
<img src="snapshots/categories_list.png" width=1000>

Edit form for category <b>Beverage</b>\
<img src="snapshots/categories_edit_form.png" width=1000>

After edit information of category <b>Beverage</b>\
<img src="snapshots/categories_edit.png" width=1000>

New form of category <b>Snack</b>\
<img src="snapshots/categories_new_form.png" width=1000>

After new information of category <b>Snack</b>\
<img src="snapshots/categories_new.png" width=1000>

List items of category <b>Dessert</b>\
<img src="snapshots/categories_list_items.png" width=1000>

After delete categories of <b>Main Dish</b>\
<img src="snapshots/categories_delete.png" width=1000>
