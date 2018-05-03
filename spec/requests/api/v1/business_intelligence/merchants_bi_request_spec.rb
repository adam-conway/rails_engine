require 'rails_helper'

describe "Merchants BI API" do
  describe "Single Merchant" do
    it "Sends total revenue for a merchant" do
      merchant = create(:merchant)
      invoice_list = create_list(:invoice, 10, merchant: merchant)
      10.times do
        create(:transaction, invoice: invoice_list.sample)
      end
      invoice_item_list = []
      10.times do
        invoice_item_list << create(:invoice_item, invoice: invoice_list.sample)
      end
      # transaction_list = create_list(:transaction, 10, invoice: invoice_list.sample)
      # invoice_item_list = create_list(:invoice_item, 10, invoice: invoice_list.sample)

      get "/api/v1/merchants/#{merchant.id}/revenue"

      successful_invoices = merchant.invoices.find_all do |invoice|
        invoice.status == "Success"
      end

      invoice_items = successful_invoices.map do |invoice|
        invoice.invoice_items
      end.flatten

      expectation = invoice_items.map do |invoice_item|
        invoice_item.quantity * invoice_item.unit_price
      end.sum

      expect(response).to be_success

      revenue = JSON.parse(response.body)

      expect(expectation).to eq(revenue)
    end
  end
end
