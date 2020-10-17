select items.id, items.name, items.price, categories.name as category from items left join (select * from item_categories join categories on categories.id = item_categories.category_id) as categories on items.id = categories.item_id;

select items.id, items.name, items.price, categories.name as category from items join item_categories on items.id = item_categories.item_id join categories on categories.id = item_categories.category_id where categories.name = 'main dish';

select items.id, items.name, items.price, categories.name as category from items join item_categories on items.id = item_categories.item_id join categories on categories.id = item_categories.category_id where categories.name = 'main dish' and items.price > 30000;

select items.id, items.name, items.price, categories.name as category from items left join (select * from item_categories join categories on categories.id = item_categories.category_id) as categories on items.id = categories.item_id where categories.name is null;

select id, name, group_concat(items separator ', '), max(price) from (select category.id, category.name, items.name as items, items.price from items join (select id, name, item_id from categories inner join item_categories on categories.id = item_categories.category_id) as category on items.id = item_id) as _ group by id;
