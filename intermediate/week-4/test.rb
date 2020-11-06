require './models/item_category.rb'

# item_category = ItemCategory.new({
#   item_id: 9,
#   category_id: 3
# })

# item_category.save

d = ItemCategory.new({
  item_id: 4,
  category_id: 1
})
d.save
