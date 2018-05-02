require 'rails_helper'

describe "Merchants BI API" do
  describe "Single Merchant" do
    it "Sends total revenue for a merchant" do
      merchant = create(:merchant)
      invoice_list = create_list(:invoice, 10, merchant: merchant, status: "Success")
      invoice_item_list = create_list(:invoice_item, 10, invoice: invoice_list.sample)

      get "/api/v1/merchants/#{merchant.id}/revenue"

      expectation = invoice_item_list.map(&:price).sum
      
      expect(response).to be_success

      revenue = JSON.parse(response.body)

      expect(expectation).to eq(revenue)
    end
  end
end
