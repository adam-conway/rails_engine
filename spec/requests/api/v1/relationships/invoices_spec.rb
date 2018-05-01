require 'rails_helper'

describe 'Invoices API' do
  describe 'relationships' do
    it 'can return transactions associated with an invoice' do
      # customer_list = create_list(:customer, 10)
      # merchant_list = create_list(:merchant, 10)
      # item_list = create_list(:item, 10)
      invoice_list = create_list(:invoice, 10)
      40.times do
        create(:transaction, invoice: invoice_list.sample)
      end

      # invoice_items_list = create_list(:invoice_item, 100)

      get "/api/v1/invoices/#{invoice_list[2].id}/transactions"

      transactions = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoice_list[2].transactions.count).to eq(transactions.count)
    end

    it 'can return invoice_items associated with an invoice' do
      # customer_list = create_list(:customer, 10)
      # merchant_list = create_list(:merchant, 10)
      # item_list = create_list(:item, 10)
      invoice_list = create_list(:invoice, 10)
      # 40.times do
      #   create(:transaction, invoice: invoice_list.sample)
      # end
      100.times do
        create(:invoice_item, invoice: invoice_list.sample)
      end

      get "/api/v1/invoices/#{invoice_list[4].id}/invoice_items"

      invoice_items = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoice_list[4].invoice_items.count).to eq(invoice_items.count)
    end

    it 'can return items associated with an invoice' do
      # customer_list = create_list(:customer, 10)
      # merchant_list = create_list(:merchant, 10)
      item_list = create_list(:item, 10)
      invoice_list = create_list(:invoice, 10)
      # 40.times do
      #   create(:transaction, invoice: invoice_list.sample)
      # end
      50.times do
        create(:invoice_item, invoice: invoice_list.sample, item: item_list.sample)
      end

      get "/api/v1/invoices/#{invoice_list[7].id}/items"

      items = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoice_list[7].items.count).to eq(items.count)
    end

    it 'can return customer associated with an invoice' do
      customer_list = create_list(:customer, 3)
      # merchant_list = create_list(:merchant, 10)
      # item_list = create_list(:item, 10)
      5.times do
        create(:invoice, customer: customer_list.sample)
      end
      # 40.times do
      #   create(:transaction, invoice: invoice_list.sample)
      # end
      # 50.times do
      #   create(:invoice_item, invoice: invoice_list.sample, item: item_list.sample)
      # end

      get "/api/v1/invoices/#{Invoice.first.id}/customer"

      customer = JSON.parse(response.body)

      expect(response).to be_success
      expect(Invoice.first.customer.id).to eq(customer["id"])
    end

    it 'can return merchant associated with an invoice' do
      merchant_list = create_list(:merchant, 3)
      # item_list = create_list(:item, 10)
      5.times do
        create(:invoice, merchant: merchant_list.sample)
      end
      # 40.times do
      #   create(:transaction, invoice: invoice_list.sample)
      # end
      # 50.times do
      #   create(:invoice_item, invoice: invoice_list.sample, item: item_list.sample)
      # end

      get "/api/v1/invoices/#{Invoice.first.id}/merchant"

      merchant = JSON.parse(response.body)

      expect(response).to be_success
      expect(Invoice.first.merchant.id).to eq(merchant["id"])
    end
  end
end
