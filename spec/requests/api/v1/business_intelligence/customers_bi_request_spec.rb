require 'rails_helper'

describe "Customers BI API" do
  describe "Customer class" do
    it '.favorite_merchant' do
      customer = create(:customer)
      merchant1 = create(:merchant)
      merchant2 = create(:merchant)
      merchant3 = create(:merchant)
      invoice1 = create(:invoice, customer: customer, merchant: merchant1)
      invoice2 = create(:invoice, customer: customer, merchant: merchant2)
      invoice3 = create(:invoice, customer: customer, merchant: merchant3)
      transaction1 = create(:transaction, invoice: invoice1, result: "Success")
      transaction2 = create(:transaction, invoice: invoice1, result: "Success")
      transaction3 = create(:transaction, invoice: invoice2, result: "Success")
      transaction4 = create(:transaction, invoice: invoice3, result: "failed")
      transaction5 = create(:transaction, invoice: invoice3, result: "failed")
      transaction6 = create(:transaction, invoice: invoice3, result: "failed")

      get "/api/v1/customers/#{customer.id}/favorite_merchant"

      merchant = JSON.parse(response.body)

      expect(merchant).to eq({"id" => merchant1.id, "name" => merchant1.name})
    end
  end
end
