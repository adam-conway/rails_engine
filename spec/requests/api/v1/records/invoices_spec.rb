require 'rails_helper'

describe 'Invoices API' do
  it 'returns index of items' do
    create_list(:item, 2)

    get '/api/v1/items'

    items = JSON.parse(response.body)

    expect(response).to be_success
    expect(items.count).to eq(2)
  end

  # it 'returns a single invoice' do
  #   create(:invoice)
  #   invoice_id = Invoice.last.id
  #
  #   get "/api/v1/invoices/#{invoice_id}"
  #
  #   invoice = JSON.parse(response.body)
  #
  #   expect(response).to be_success
  #   expect(invoice["id"]).to eq(invoice_id)
  # end
  #
  # it 'can return single invoice by passing id param' do
  #   create(:invoice)
  #   id = Invoice.last.id
  #
  #   get "/api/v1/invoices/find?id=#{id}"
  #
  #   invoice = JSON.parse(response.body)
  #
  #   expect(response).to be_success
  #   expect(invoice["id"]).to eq(id)
  # end
  #
  # it 'can return single invoice by passing status param' do
  #   create(:invoice)
  #   status = Invoice.last.status
  #
  #   get "/api/v1/invoices/find?status=#{status}"
  #
  #   invoice = JSON.parse(response.body)
  #
  #   expect(response).to be_success
  #   expect(invoice["status"]).to eq(status)
  # end
  #
  # it 'can return single invoice by passing status param; case-insensitive' do
  #   create(:invoice)
  #   status = Invoice.last.status
  #
  #   get "/api/v1/invoices/find?status=#{status.upcase}"
  #
  #   invoice = JSON.parse(response.body)
  #
  #   expect(response).to be_success
  #   expect(invoice["status"]).to eq(status)
  # end
  #
  # it 'can return single invoice by passing merchant_id param' do
  #   create(:invoice)
  #   merchant_id = Invoice.last.merchant_id
  #
  #   get "/api/v1/invoices/find?merchant_id=#{merchant_id}"
  #
  #   invoice = JSON.parse(response.body)
  #
  #   expect(response).to be_success
  #   expect(invoice["merchant_id"]).to eq(merchant_id)
  # end
  #
  # it 'can return single invoice by passing customer_id param' do
  #   create(:invoice)
  #   customer_id = Invoice.last.customer_id
  #
  #   get "/api/v1/invoices/find?customer_id=#{customer_id}"
  #
  #   invoice = JSON.parse(response.body)
  #
  #   expect(response).to be_success
  #   expect(invoice["customer_id"]).to eq(customer_id)
  # end
  #
  # it 'can return single invoice by passing created_at param' do
  #   create(:invoice)
  #   id = Invoice.last.id
  #   created_at = Invoice.last.created_at
  #
  #   get "/api/v1/invoices/find?created_at=#{created_at}"
  #
  #   invoice = JSON.parse(response.body)
  #
  #   expect(response).to be_success
  #   expect(invoice["id"]).to eq(id)
  # end
  #
  # it 'can return single invoice by passing updated_at param' do
  #   create(:invoice)
  #   id = Invoice.last.id
  #   updated_at = Invoice.last.updated_at
  #
  #   get "/api/v1/invoices/find?updated_at=#{updated_at}"
  #
  #   invoice = JSON.parse(response.body)
  #
  #   expect(response).to be_success
  #   expect(invoice["id"]).to eq(id)
  # end
  #
  # it 'can return all invoices matching a status param' do
  #   create(:invoice, status: "shipped")
  #   create_list(:invoice, 3, status: "pending")
  #
  #   status = Invoice.last.status
  #
  #   get "/api/v1/invoices/find_all?status=#{status}"
  #
  #   invoice = JSON.parse(response.body)
  #
  #   expect(response).to be_success
  #   expect(invoice.count).to eq(3)
  # end
  #
  # it 'can return all invoices matching a status param; case-insensitive' do
  #   create(:invoice, status: "shipped")
  #   create_list(:invoice, 3, status: "pending")
  #
  #   status = Invoice.last.status
  #
  #   get "/api/v1/invoices/find_all?status=#{status.upcase}"
  #
  #   invoice = JSON.parse(response.body)
  #
  #   expect(response).to be_success
  #   expect(invoice.count).to eq(3)
  # end
  #
  # it 'can return all invoices matching a merchant_id param' do
  #   create(:merchant, id: 1)
  #   create(:merchant, id: 2)
  #   create(:invoice, merchant_id: 1)
  #   create_list(:invoice, 4, merchant_id: 2)
  #
  #   merchant_id = Invoice.last.merchant_id
  #
  #   get "/api/v1/invoices/find_all?merchant_id=#{merchant_id}"
  #
  #   invoice = JSON.parse(response.body)
  #
  #   expect(response).to be_success
  #   expect(invoice.count).to eq(4)
  # end
  #
  # it 'can return all invoices matching a customer_id param' do
  #   create(:customer, id: 1)
  #   create(:customer, id: 2)
  #   create(:invoice, customer_id: 1)
  #   create_list(:invoice, 8, customer_id: 2)
  #
  #   customer_id = Invoice.last.customer_id
  #
  #   get "/api/v1/invoices/find_all?customer_id=#{customer_id}"
  #
  #   invoice = JSON.parse(response.body)
  #
  #   expect(response).to be_success
  #   expect(invoice.count).to eq(8)
  # end
  #
  # it 'can return all invoices matching a created_at param' do
  #   create(:invoice, created_at: Date.yesterday)
  #   create_list(:invoice, 3)
  #   created_at = Invoice.last.created_at
  #
  #   get "/api/v1/invoices/find_all?created_at=#{created_at}"
  #
  #   invoice = JSON.parse(response.body)
  #
  #   expect(response).to be_success
  #   expect(invoice.count).to eq(3)
  # end
  #
  # it 'can return all invoices matching a updated_at param' do
  #   create(:invoice, updated_at: Date.yesterday)
  #   create_list(:invoice, 3)
  #   updated_at = Invoice.last.updated_at
  #
  #   get "/api/v1/invoices/find_all?updated_at=#{updated_at}"
  #
  #   invoice = JSON.parse(response.body)
  #
  #   expect(response).to be_success
  #   expect(invoice.count).to eq(3)
  # end
  #
  # it 'can return a random invoice' do
  #   invoices = create_list(:invoice, 5)
  #
  #   get '/api/v1/invoices/random'
  #
  #   invoice = JSON.parse(response.body)
  #
  #   expect(response).to be_success
  #   expect(invoices.map(&:id).include?(invoice["id"]))
  # end
end
