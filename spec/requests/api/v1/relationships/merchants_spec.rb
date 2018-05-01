describe 'Merchants API' do
  describe 'relationships' do
    it 'can return all items associated with a merchant' do
      create(:merchant)
      id = Merchant.last.id
      id_2 = id + 1
      create(:merchant, id: id_2)
      create_list(:item, 6, merchant_id: id)
      create_list(:item, 6, merchant_id: id_2)
      get "/api/v1/merchants/#{id}/items"

      items = JSON.parse(response.body)

      expect(response).to be_success
      expect(items.count).to eq(6)
    end

    it 'can return all invoices associated with a merchant' do
      create(:merchant)
      id = Merchant.last.id
      id_2 = id + 1
      create(:merchant, id: id_2)
      create_list(:invoice, 5, merchant_id: id)
      create_list(:invoice, 5, merchant_id: id_2)

      get "/api/v1/merchants/#{id}/invoices"

      items = JSON.parse(response.body)

      expect(response).to be_success
      expect(items.count).to eq(5)
    end
  end
end
