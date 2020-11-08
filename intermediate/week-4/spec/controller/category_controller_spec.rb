require './models/category.rb'
require './db/mysql_connector.rb'
require './controllers/category_controller'

describe CategoryController do
  before (:each) do
    client = create_db_client
    client.query("truncate table item_categories")
    client.query("set FOREIGN_KEY_CHECKS = 0")
    client.query("truncate table categories")
    client.query("set FOREIGN_KEY_CHECKS = 1")
    client.query('insert into categories (name) values ("Main Dish")')
    client.query('insert into categories (name) values ("Beverages")')
    client.query('insert into categories (name) values ("Dessert")')
    client.close

    @categories = [
      Category.new({
        id: 1,
        name: 'Main Dish'
      }),
      Category.new({
        id: 2,
        name: 'Beverages'
      }),
      Category.new({
        id: 3,
        name: 'Dessert'
      })
    ]
  end

  # describe '.show' do
  #   it 'should show all categories' do
  #     expected_response = ERB.new(File.read("./views/categories/list.erb")).result_with_hash({
  #       categories: @categories
  #     })
  #     expect(CategoryController.show).to eq(expected_response)
  #   end
  # end

  describe '.create' do
    before(:each) do
      @new_category = Category.new({
        id: 4,
        name: 'Snack'
      })
      @response = CategoryController.create({
        name: 'Snack'
      })
    end
    
    it 'should add new category to db' do
      added_category = Category.find_by_id(4)[0]
      expect(added_category).to eq(@new_category)
    end
  end
end