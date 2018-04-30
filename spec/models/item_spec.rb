require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:name)}
    it {should validate_presence_of(:description)}
    it {should validate_presence_of(:price)}
    it {should belong_to(:merchant)}
    it {should have_many(:invoices).through(:invoice_items)}
  end

  describe 'field validations' do
    it 'is invalid without a name' do
      item = Item.create(description: 'description', price: 100)

      expect(item).to_not be_valid
    end

    it 'is invalid without a description' do
      item = Item.create(name: 'item', price: 100)

      expect(item).to_not be_valid
    end

    it 'is invalid without a price' do
      item = Item.create(name: 'item', description: 'description')

      expect(item).to_not be_valid
    end

    it 'should be valid with all attributes' do
      item = create(:item)

      expect(item).to be_valid
    end
  end
end
