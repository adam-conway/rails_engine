require 'rails_helper'

describe 'Items API' do
  describe 'relationships' do
    it 'can return merchant associated with an item' do
      merchant1 = create(:merchant)
      merchant2 = create(:merchant)
      merchant3 = create(:merchant)
      item1 = create(:item, merchant: merchant1)
      item2 = create(:item, merchant: merchant2)
      item3 = create(:item, merchant: merchant3)

      get "/api/v1/items/#{item2.id}/merchant"

      merchant = JSON.parse(response.body)

      expect(response).to be_success
      expect(merchant["id"]).to eq(merchant2.id)
    end

    it 'can return invoice_items associated with an item' do
      item_list = create_list(:item, 3)
      10.times do
        create(:invoice_item, item: item_list.sample)
      end

      get "/api/v1/items/#{item_list[2].id}/invoice_items"

      invoice_items = JSON.parse(response.body)

      expect(response).to be_success
      expect(item_list[2].invoice_items.count).to eq(invoice_items.count)
    end
  end
end
