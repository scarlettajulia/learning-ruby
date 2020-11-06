# Week-3 Homework
This folder is used for the homework and exercise in week-3.

## Project Structure
The structure of the project is explained in below. The tag `homework` means the file is the homeworks files.
```
|_ controllers
| |_ item_controller.rb
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
|_ views
| |_ detail_item.erb  
| |_ edit_item.erb
| |_ list_items.erb
| |_ new_item.erb     
|_ main.rb            
|_ README.md
```

## Instructions
1. Install the needed gems.
```
gem install sinatra
gem install mysql2
gem install mysql2-cs-bind
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