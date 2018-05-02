require 'rails_helper'

describe 'Items API' do
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

  it 'can return single item by passing name param' do
    create(:item)
    name = Item.last.name

    get "/api/v1/items/find?name=#{name}"

    item = JSON.parse(response.body)

    expect(response).to be_success
    expect(item["name"]).to eq(name)
  end

  it 'can return single item by passing name param; case-insensitive' do
    create(:item)
    name = Item.last.name

    get "/api/v1/items/find?name=#{name.upcase}"

    item = JSON.parse(response.body)

    expect(response).to be_success
    expect(item["name"]).to eq(name)
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

  skip 'can return single item by passing unit_price param' do
    create(:item)
    unit_price = Item.last.unit_price

    get "/api/v1/items/find?unit_price=#{unit_price}"

    item = JSON.parse(response.body)

    expect(response).to be_success
    expect(item["unit_price"]).to eq(unit_price)
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

  it 'can return all items matching an id param' do
    create(:item, id: 1)
    create_list(:item, 3)
    id = Item.last.id

    get "/api/v1/items/find_all?id=#{id}"

    items = JSON.parse(response.body)

    expect(response).to be_success
    expect(items.count).to eq(1)
  end

  it 'can return all items matching an name param' do
    create(:item)
    create_list(:item, 3, name: "Name")
    name = Item.last.name

    get "/api/v1/items/find_all?name=#{name}"

    items = JSON.parse(response.body)

    expect(response).to be_success
    expect(items.count).to eq(3)
  end

  it 'can return all items matching an name param; case-insensitive' do
    create(:item)
    create_list(:item, 3, name: "Name")
    name = Item.last.name

    get "/api/v1/items/find_all?name=#{name.upcase}"

    items = JSON.parse(response.body)

    expect(response).to be_success
    expect(items.count).to eq(3)
  end

  it 'can return all items matching a description param' do
    create(:item, description: "not a description")
    create_list(:item, 3, description: "description")
    description = Item.last.description

    get "/api/v1/items/find_all?description=#{description}"

    items = JSON.parse(response.body)

    expect(response).to be_success
    expect(items.count).to eq(3)
  end

  it 'can return all items matching a description param; case-insensitive' do
    create(:item, description: "not a description")
    create_list(:item, 3, description: "description")
    description = Item.last.description

    get "/api/v1/items/find_all?description=#{description.upcase}"

    items = JSON.parse(response.body)

    expect(response).to be_success
    expect(items.count).to eq(3)
  end

  it 'can return all items matching a unit_price param' do
    create(:item, unit_price: 1)
    create_list(:item, 4, unit_price: 2)
    unit_price = Item.last.unit_price

    get "/api/v1/items/find_all?unit_price=#{unit_price}"

    items = JSON.parse(response.body)

    expect(response).to be_success
    expect(items.count).to eq(4)
  end

  it 'can return all items matching a merchant_id param' do
    create(:merchant, id: 1)
    create(:merchant, id: 2)
    create(:item, merchant_id: 1)
    create_list(:item, 10, merchant_id: 2)
    merchant_id = Item.last.merchant_id

    get "/api/v1/items/find_all?merchant_id=#{merchant_id}"

    items = JSON.parse(response.body)

    expect(response).to be_success
    expect(items.count).to eq(10)
  end

  it 'can return all items matching a created_at param' do
    create(:item)
    create_list(:item, 7, created_at: "2018-04-31 12:12:12 UTC")
    created_at = Item.last.created_at

    get "/api/v1/items/find_all?created_at=#{created_at}"

    items = JSON.parse(response.body)

    expect(response).to be_success
    expect(items.count).to eq(7)
  end

  it 'can return all items matching a updated_at param' do
    create(:item)
    create_list(:item, 7, updated_at: "2018-04-31 11:11:11 UTC")
    updated_at = Item.last.updated_at

    get "/api/v1/items/find_all?updated_at=#{updated_at}"

    items = JSON.parse(response.body)

    expect(response).to be_success
    expect(items.count).to eq(7)
  end

  it 'can return a random item' do
    items = create_list(:item, 5)

    get '/api/v1/items/random'

    item = JSON.parse(response.body)

    expect(response).to be_success
    expect(items.map(&:id).include?(item["id"]))
  end
end
