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

    it '.best day' do
      item1 = create(:item)
      invoice_list1 = create_list(:invoice, 3, created_at: "2018-04-30 10:45:00 UTC")
      invoice_list2 = create_list(:invoice, 4, created_at: "2018-05-30 10:45:00 UTC")

      create(:invoice_item, invoice: invoice_list1[0], item: item1)
      create(:invoice_item, invoice: invoice_list1[1], item: item1)
      create(:invoice_item, invoice: invoice_list1[2], item: item1)
      create(:invoice_item, invoice: invoice_list2[0], item: item1)
      create(:invoice_item, invoice: invoice_list2[1], item: item1)
      create(:invoice_item, invoice: invoice_list2[2], item: item1)
      create(:invoice_item, invoice: invoice_list2[3], item: item1)

      create(:transaction, invoice: invoice_list1[0], result: "Success")
      create(:transaction, invoice: invoice_list1[1], result: "Success")
      create(:transaction, invoice: invoice_list1[2], result: "Success")

      create(:transaction, invoice: invoice_list2[0], result: "Success")
      create(:transaction, invoice: invoice_list2[1], result: "Success")
      create(:transaction, invoice: invoice_list2[2], result: "Failure")
      create(:transaction, invoice: invoice_list2[3], result: "Failure")

      get "/api/v1/items/#{item1.id}/best_day"

      day = JSON.parse(response.body)

      expect(day).to eq({"best_day"=>"2018-04-30T10:45:00.000Z"})
    end

    it '.most sold item' do
      item1 = create(:item)
      item2 = create(:item)
      item3 = create(:item)
      invoice1 = create(:invoice)
      invoice2 = create(:invoice)
      invoice3 = create(:invoice)

      create(:invoice_item, invoice: invoice1, item: item1, unit_price: 100, quantity: 1)
      create(:invoice_item, invoice: invoice2, item: item2, unit_price: 100, quantity: 3)
      create(:invoice_item, invoice: invoice3, item: item3, unit_price: 100, quantity: 1)

      create(:transaction, invoice: invoice1, result: "Success")
      create(:transaction, invoice: invoice2, result: "Success")
      create(:transaction, invoice: invoice3, result: "Success")

      expected = [{"id"=>item2.id,
        "name"=>item2.name,
        "description"=>item2.description,
        "merchant_id"=>item2.merchant_id,
        "unit_price"=>item2.unit_price.to_s}]

      get "/api/v1/items/most_items?quantity=1"

      item = JSON.parse(response.body)

      expect(item).to eq(expected)
    end
  end
end
