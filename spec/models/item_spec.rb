require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:name)}
    it {should validate_presence_of(:description)}
    it {should validate_presence_of(:unit_price)}
    it {should belong_to(:merchant)}
    it {should have_many(:invoices).through(:invoice_items)}
  end

  describe 'field validations' do
    it 'is invalid without a name' do
      item = Item.create(description: 'description', unit_price: 100)

      expect(item).to_not be_valid
    end

    it 'is invalid without a description' do
      item = Item.create(name: 'item', unit_price: 100)

      expect(item).to_not be_valid
    end

    it 'is invalid without a unit_price' do
      item = Item.create(name: 'item', description: 'description')

      expect(item).to_not be_valid
    end

    it 'should be valid with all attributes' do
      item = create(:item)

      expect(item).to be_valid
    end
  end

  describe 'class methods' do
    it '.most_revenue' do
      item_1 = create(:item, id: 4)
      item_2 = create(:item, id: 5)
      item_3 = create(:item, id: 6)

      merchant = create(:merchant)
      customer = create(:customer)

      invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id, status: "status")

      create_list(:invoice_item, 5, quantity: 5, unit_price: 5, invoice_id: invoice.id, item_id: item_1.id)
      create_list(:invoice_item, 4, quantity: 5, unit_price: 5, invoice_id: invoice.id, item_id: item_2.id)
      create_list(:invoice_item, 3, quantity: 5, unit_price: 5, invoice_id: invoice.id, item_id: item_3.id)

      expect(Item.most_revenue(2)).to include(item_1)
      expect(Item.most_revenue(2)).to include(item_2)
      expect(Item.most_revenue(2)).to_not include(item_3)
    end
  end
end
