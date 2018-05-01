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
  end
end
