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

  it 'can return single item by passing description param; case-insensitive' do
    create(:item)
    description = Item.last.description

    get "/api/v1/items/find?description=#{description.upcase}"

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

  it 'can return a random item' do
    items = create_list(:item, 5)

    get '/api/v1/items/random'

    item = JSON.parse(response.body)

    expect(response).to be_success
    expect(items.map(&:id).include?(item["id"]))
  end
end
