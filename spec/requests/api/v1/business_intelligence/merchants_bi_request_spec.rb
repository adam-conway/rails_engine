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

      expect({"revenue"=>"20000.0"}).to eq(revenue)
    end

    it 'customers with pending invoices' do
      merchant = create(:merchant, id: 1)
      customer_1 = create(:customer, id: 1)
      customer_2 = create(:customer, id: 2)

      customer_1_invoice = customer_1.invoices.create!(merchant_id: "#{merchant.id}", status: "good")
      customer_2_invoice = customer_2.invoices.create!(merchant_id: "#{merchant.id}", status: "good")

      create_list(:transaction, 3, invoice_id: "#{customer_1_invoice.id}", result: "failed")
      create_list(:transaction, 3, invoice_id: "#{customer_2_invoice.id}", result: "success")
      create_list(:transaction, 3, invoice_id: "#{customer_2_invoice.id}", result: "failed")

      get "/api/v1/merchants/#{merchant.id}/customers_with_pending_invoices"

      customers = JSON.parse(response.body).first

      expect(customers["id"]).to eq(customer_1.id)
      expect(customers["first_name"]).to eq(customer_1.first_name)
      expect(customers["last_name"]).to eq(customer_1.last_name)
    end

    it 'favorite customer' do
      merchant = create(:merchant, id: 1)
      customer_1 = create(:customer, id: 1)
      customer_2 = create(:customer, id: 2)

      customer_1_invoice = customer_1.invoices.create!(merchant_id: "#{merchant.id}", status: "good")
      customer_2_invoice = customer_2.invoices.create!(merchant_id: "#{merchant.id}", status: "good")

      create_list(:transaction, 3, invoice_id: "#{customer_1_invoice.id}", result: "failed")
      create_list(:transaction, 4, invoice_id: "#{customer_2_invoice.id}", result: "success")
      create_list(:transaction, 3, invoice_id: "#{customer_2_invoice.id}", result: "failed")

      get "/api/v1/merchants/#{merchant.id}/favorite_customer"

      favorite_customer = JSON.parse(response.body)

      expect(favorite_customer["id"]).to eq(customer_2.id)
      expect(favorite_customer["first_name"]).to eq(customer_2.first_name)
      expect(favorite_customer["last_name"]).to eq(customer_2.last_name)
    end

    it "Sends total revenue for a merchant filtered by date" do
      merchant = create(:merchant)
      invoice1 = create(:invoice, merchant: merchant)
      invoice2 = create(:invoice, merchant: merchant, created_at: "2017-06-30 10:45:00 UTC")
      invoice3 = create(:invoice, merchant: merchant)
      create(:transaction, invoice: invoice1, result: "Success")
      create(:transaction, invoice: invoice2, result: "Success")
      create(:transaction, invoice: invoice3, result: "Failed")
      create(:invoice_item, invoice: invoice1, unit_price: 100, quantity: 100)
      create(:invoice_item, invoice: invoice2, unit_price: 100, quantity: 100)
      create(:invoice_item, invoice: invoice3, unit_price: 1234, quantity: 1345)

      get "/api/v1/merchants/#{merchant.id}/revenue?date=#{invoice2.created_at}"

      expect(response).to be_success

      revenue = JSON.parse(response.body)

      expect({"revenue"=>"10000.0"}).to eq(revenue)
    end

    it "Sends top merchants by items sold" do
      merchant1 = create(:merchant)
      merchant2 = create(:merchant)
      merchant3 = create(:merchant)
      invoice1 = create(:invoice, merchant: merchant1)
      invoice2 = create(:invoice, merchant: merchant2)
      invoice3 = create(:invoice, merchant: merchant3)
      create(:transaction, invoice: invoice1, result: "Success")
      create(:transaction, invoice: invoice2, result: "Success")
      create(:transaction, invoice: invoice3, result: "Failed")
      create(:invoice_item, invoice: invoice1, unit_price: 100, quantity: 100)
      create(:invoice_item, invoice: invoice2, unit_price: 100, quantity: 1345)
      create(:invoice_item, invoice: invoice3, unit_price: 1234, quantity: 2000)

      get "/api/v1/merchants/most_items?quantity=1"

      expect(response).to be_success

      merchants = JSON.parse(response.body)

      expect(merchants.first.has_value?(merchant2.id))
    end
  end
end
