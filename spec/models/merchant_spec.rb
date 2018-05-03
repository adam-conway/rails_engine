require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe "validations" do
    it {should validate_presence_of(:name)}
    it {should have_many(:invoices)}
  end

  describe 'Field validations' do
    context 'invalid attributes' do
      it 'is invalid without a name' do
        merchant = Merchant.create()

        expect(merchant).to_not be_valid
      end
    end
    context 'valid attributes' do
      it 'is valid with all attributesß' do
        merchant = create(:merchant)

        expect(merchant).to be_valid
      end
    end
  end

  describe "queries" do
    it 'finds a merchants total revenue' do
      merchant = create(:merchant)
      invoice_list = create_list(:invoice, 3, merchant: merchant)
      create(:transaction, invoice: invoice_list[0], result: "Success")
      create(:transaction, invoice: invoice_list[1], result: "Success")
      create(:transaction, invoice: invoice_list[2], result: "Failed")
      create(:invoice_item, invoice: invoice_list[0], unit_price: 100, quantity: 100)
      create(:invoice_item, invoice: invoice_list[1], unit_price: 100, quantity: 100)
      create(:invoice_item, invoice: invoice_list[2], unit_price: 1234, quantity: 1345)

      expect(merchant.single_merchant_revenue.revenue.to_f).to eq(20000)
    end

    it '.customers_with_pending_invoices' do
      merchant = create(:merchant, id: 1)
      customer_1 = create(:customer, id: 1)
      customer_2 = create(:customer, id: 2)

      customer_1_invoice = customer_1.invoices.create!(merchant_id: "#{merchant.id}", status: "good")
      customer_2_invoice = customer_2.invoices.create!(merchant_id: "#{merchant.id}", status: "good")

      create_list(:transaction, 3, invoice_id: "#{customer_1_invoice.id}", result: "failed")
      create_list(:transaction, 3, invoice_id: "#{customer_2_invoice.id}", result: "success")
      create_list(:transaction, 3, invoice_id: "#{customer_2_invoice.id}", result: "failed")

      expect(merchant.customers_with_pending_invoices.first). to eq(customer_1)
    end

    it '.favorite_customer' do
      merchant = create(:merchant, id: 1)
      customer_1 = create(:customer, id: 1)
      customer_2 = create(:customer, id: 2)

      customer_1_invoice = customer_1.invoices.create!(merchant_id: "#{merchant.id}", status: "good")
      customer_2_invoice = customer_2.invoices.create!(merchant_id: "#{merchant.id}", status: "good")

      create_list(:transaction, 3, invoice_id: "#{customer_1_invoice.id}", result: "failed")
      create_list(:transaction, 4, invoice_id: "#{customer_2_invoice.id}", result: "success")
      create_list(:transaction, 3, invoice_id: "#{customer_2_invoice.id}", result: "failed")

      expect(merchant.favorite_customer). to eq(customer_2)
    end

    it 'finds a merchants total revenue by date' do
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

      search_param = "2017-6-30"

      expect(merchant.single_merchant_revenue_by_date(search_param).revenue.to_f).to eq(10000)
    end
  end
end
