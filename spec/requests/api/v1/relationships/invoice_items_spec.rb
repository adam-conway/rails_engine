require 'rails_helper'

describe 'Invoice items API' do
  describe 'relationships' do
    it 'can return invoice associated with an invoice_item' do
      invoice_list = create_list(:invoice, 6)
      item_list = create_list(:item, 6)
      invoice_item = create(:invoice_item, item: item_list.sample, invoice: invoice_list.sample)

      get "/api/v1/invoice_items/#{invoice_item.id}/invoice"

      invoice = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoice["id"]).to eq(invoice_item.invoice.id)
    end
    it 'can return item associated with an invoice_item' do
      invoice_list = create_list(:invoice, 6)
      item_list = create_list(:item, 6)
      invoice_item = create(:invoice_item, item: item_list.sample, invoice: invoice_list.sample)

      get "/api/v1/invoice_items/#{invoice_item.id}/item"

      item = JSON.parse(response.body)

      expect(response).to be_success
      expect(item).to eq(invoice_item.item)
    end
  end
end
