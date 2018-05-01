require 'rails_helper'

describe 'Items API' do
  describe 'relationships' do
    it 'can return merchant associated with an item' do
      #waiting for items to get finished
      skip
      merchant1 = create(:merchant)
      merchant2 = create(:merchant)
      merchant3 = create(:merchant)
      item1 = create(:item, merchant: merchant1)
      item2 = create(:item, merchant: merchant2)
      item3 = create(:item, merchant: merchant3)

      get "/api/v1/items/#{item2.id}/merchant"

      merchant = JSON.parse(response.body)

      expect(response).to be_success
      expect(merchant.id).to eq(merchant2.id)
    end

    # it 'can return all invoice_items associated with an item' do
    #   create(:item)
    #   id = Item.last.id
    #   id_2 = id + 1
    #   create(:item, id: id_2)
    #   create_list(:invoice, 5, item_id: id)
    #   create_list(:invoice, 5, item_id: id_2)
    #
    #   get "/api/v1/items/#{id}/invoices"
    #
    #   items = JSON.parse(response.body)
    #
    #   expect(response).to be_success
    #   expect(items.count).to eq(5)
    # end
  end
end
