require './models/item'
require './models/category'
require './db/mysql_connector.rb'

describe Category do
  describe 'non-db-related' do
    describe '#valid?' do
      context 'when initialized with valid input' do 
        it 'should return true' do
          category = Category.new({
            id: 1,  
            name: 'Main Dish'
          })
          expect(category.valid?).to eq(true)
        end
      end

      context 'when initialized with invalid input' do
        it 'should return false' do
          category = Category.new({
            id: 1
          })
          expect(category.valid?).to eq (false)
        end
      end
    end
  end
  describe 'db-related' do
    before (:each) do
      client = create_db_client
      client.query("truncate table item_categories")
      client.query("set FOREIGN_KEY_CHECKS = 0")
      client.query("truncate table categories")
      client.query("set FOREIGN_KEY_CHECKS = 1")
      client.close
    end

    describe '.find_by_id' do
      context 'when table is empty' do 
        it 'should return empty' do
          category = Category.find_by_id(1)
          expect(category).to eq([])
        end

        it 'should return empty' do
          category = Category.find_by_id(1)
          expect(category).not_to eq([Category.new])
        end
      end

      context 'when table is not empty' do
        before(:each) do
          client = create_db_client
          client.query('insert into categories (name) values ("Main Dish")')
          client.query('insert into categories (name) values ("Beverages")')
          client.query('insert into categories (name) values ("Dessert")')
          client.close
        end

        it 'find by id 1 return item with id 1 should return true' do
          expected_category = Category.new({
            id: 1,
            name: 'Main Dish'
          })
          expect(Category.find_by_id(1)).to eq([expected_category])
        end

        it 'find by id 1 return item with id 2 should return false' do
          expected_category = Category.new({
            id: 2,
            name: 'Beverages'
          })
          expect(Category.find_by_id(1)).not_to eq([expected_category])
        end
      end
    end
  end
end