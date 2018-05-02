require 'rails_helper'

describe 'InvoiceItems API' do
  it 'returns index of invoice_items' do
    create_list(:invoice_item, 2)

    get '/api/v1/invoice_items'

    items = JSON.parse(response.body)

    expect(response).to be_success
    expect(items.count).to eq(2)
  end

  it 'returns a single invoice_item' do
    create_list(:invoice_item, 2)
    invoice_item_id = InvoiceItem.last.id

    get "/api/v1/invoice_items/#{invoice_item_id}"

    invoice_item = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice_item["id"]).to eq(invoice_item_id)
  end

  it 'can return single invoice_item by passing id param' do
    create_list(:invoice_item, 2)
    id = InvoiceItem.last.id

    get "/api/v1/invoice_items/find?id=#{id}"

    invoice_item = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice_item["id"]).to eq(id)
  end

  it 'can return single invoice_item by passing quantity param' do
    create_list(:invoice_item, 2)
    quantity = InvoiceItem.last.quantity

    get "/api/v1/invoice_items/find?quantity=#{quantity}"

    invoice_item = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice_item["quantity"]).to eq(quantity)
  end

  it 'can return single invoice_item by passing unit_price param' do
    create_list(:invoice_item, 2)
    unit_price = InvoiceItem.last.unit_price.to_s

    get "/api/v1/invoice_items/find?unit_price=#{unit_price}"

    invoice_item = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice_item["unit_price"]).to eq(unit_price)
  end

  it 'can return single invoice_item by passing invoice_id param' do
    create_list(:invoice_item, 2)
    invoice_id = InvoiceItem.last.invoice_id

    get "/api/v1/invoice_items/find?invoice_id=#{invoice_id}"

    invoice_item = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice_item["invoice_id"]).to eq(invoice_id)
  end

  it 'can return single invoice_item by passing item_id param' do
    create_list(:invoice_item, 2)
    item_id = InvoiceItem.last.item_id

    get "/api/v1/invoice_items/find?item_id=#{item_id}"

    item_item = JSON.parse(response.body)

    expect(response).to be_success
    expect(item_item["item_id"]).to eq(item_id)
  end

  it 'can return all invoice_items matching an id param' do
    create(:invoice_item, id: 1)
    create_list(:invoice_item, 3)
    id = InvoiceItem.last.id

    get "/api/v1/invoice_items/find_all?id=#{id}"

    invoice_items = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice_items.count).to eq(1)
  end

  it 'can return all invoice_items matching an quantity param' do
    create(:invoice_item, quantity: 1)
    create_list(:invoice_item, 3, quantity: 2)
    quantity = InvoiceItem.last.quantity

    get "/api/v1/invoice_items/find_all?quantity=#{quantity}"

    invoice_items = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice_items.count).to eq(3)
  end

  it 'can return all invoice_items matching an unit_price param' do
    create(:invoice_item, unit_price: 1)
    create_list(:invoice_item, 3, unit_price: 3)
    unit_price = InvoiceItem.last.unit_price

    get "/api/v1/invoice_items/find_all?unit_price=#{unit_price}"

    invoice_items = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice_items.count).to eq(3)
  end

  it 'can return all invoice_items matching an invoice_id param' do
    create(:invoice, id: 1)
    create_list(:invoice_item, 3)
    invoice_id = InvoiceItem.last.invoice_id

    get "/api/v1/invoice_items/find_all?invoice_id=#{invoice_id}"

    invoice_items = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice_items.count).to eq(1)
  end

  it 'can return all invoice_items matching an item_id param' do
    create(:item, id: 1)
    create_list(:invoice_item, 3)
    item_id = InvoiceItem.last.item_id

    get "/api/v1/invoice_items/find_all?item_id=#{item_id}"

    invoice_items = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice_items.count).to eq(1)
  end
end
