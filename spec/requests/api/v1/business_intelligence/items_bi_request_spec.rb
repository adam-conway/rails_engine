require 'rails_helper'

describe "Items BI API" do
  describe "Item class" do
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

      get '/api/v1/items/most_revenue?quantity=2'

      items = JSON.parse(response.body)

      expect(items.count).to eq(2)
      expect(items.first["id"]).to eq(item_1.id)
      expect(items.first["name"]).to eq(item_1.name)
      expect(items.second["id"]).to eq(item_2.id)
      expect(items.second["name"]).to eq(item_2.name)
    end
  end
end
