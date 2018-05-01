require 'rails_helper'

describe 'Invoices API' do
  it 'returns index of items' do
    create_list(:item, 2)

    get '/api/v1/items'

    items = JSON.parse(response.body)

    expect(response).to be_success
    expect(items.count).to eq(2)
  end

  it 'returns a single item' do
    create(:item)
    item_id = Item.last.id

    get "/api/v1/items/#{item_id}"

    item = JSON.parse(response.body)

    expect(response).to be_success
    expect(item["id"]).to eq(item_id)
  end

  it 'can return single item by passing id param' do
    create(:item)
    id = Item.last.id

    get "/api/v1/items/find?id=#{id}"

    item = JSON.parse(response.body)

    expect(response).to be_success
    expect(item["id"]).to eq(id)
  end

  it 'can return single item by passing description param' do
    create(:item)
    description = Item.last.description

    get "/api/v1/items/find?description=#{description}"

    item = JSON.parse(response.body)

    expect(response).to be_success
    expect(item["description"]).to eq(description)
  end

  skip 'can return single item by passing price param' do
    create(:item)
    price = Item.last.price

    get "/api/v1/items/find?price=#{price}"

    item = JSON.parse(response.body)

    expect(response).to be_success
    expect(item["price"]).to eq(price)
  end

  it 'can return single item by passing merchant_id param' do
    create(:item)
    merchant_id = Item.last.merchant_id

    get "/api/v1/items/find?merchant_id=#{merchant_id}"

    item = JSON.parse(response.body)

    expect(response).to be_success
    expect(item["merchant_id"]).to eq(merchant_id)
  end

  it 'can return single item by passing created_at param' do
    create(:item)
    id = Item.last.id
    created_at = Item.last.created_at

    get "/api/v1/items/find?created_at=#{created_at}"

    item = JSON.parse(response.body)

    expect(response).to be_success
    expect(item["id"]).to eq(id)
  end

  it 'can return single item by passing updated_at param' do
    create(:item)
    id = Item.last.id
    updated_at = Item.last.updated_at

    get "/api/v1/items/find?updated_at=#{updated_at}"

    item = JSON.parse(response.body)

    expect(response).to be_success
    expect(item["id"]).to eq(id)
  end

  # it 'can return all invoices matching a status param' do
  #   create(:invoice, status: "shipped")
  #   create_list(:invoice, 3, status: "pending")
  #
  #   status = Item.last.status
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
