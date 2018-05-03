require 'rails_helper'

describe "Merchants BI API" do
  describe "Single Merchant" do
    it "Sends total revenue for a merchant" do
      merchant = create(:merchant)
      invoice_list = create_list(:invoice, 3, merchant: merchant)
      create(:transaction, invoice: invoice_list[0], result: "Success")
      create(:transaction, invoice: invoice_list[1], result: "Success")
      create(:transaction, invoice: invoice_list[2], result: "Failed")
      create(:invoice_item, invoice: invoice_list[0], unit_price: 100, quantity: 100)
      create(:invoice_item, invoice: invoice_list[1], unit_price: 100, quantity: 100)
      create(:invoice_item, invoice: invoice_list[2], unit_price: 1234, quantity: 1345)

      get "/api/v1/merchants/#{merchant.id}/revenue"

      expect(response).to be_success

      revenue = JSON.parse(response.body)

      expect({"revenue"=>"200.0"}).to eq(revenue)
    end
  end
end
