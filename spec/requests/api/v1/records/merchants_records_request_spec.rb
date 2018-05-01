require 'rails_helper'

describe "Merchants API" do

  it "sends a list of merchants" do
    merchant_list = create_list(:merchant, 3)

    get '/api/v1/merchants'

    expect(response).to be_success

    merchants = JSON.parse(response.body)

    expect(merchants.count).to eq(merchant_list.count)
  end

  it "can get one merchant by its id" do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"

    merchant = JSON.parse(response.body)

    expect(response).to be_success
    expect(merchant["id"]).to eq(id)
  end

  it "can get one merchant based on id" do
    merchant_list = create_list(:merchant, 10)

    get "/api/v1/merchants/find?id=#{merchant_list[1].id}"

    merchant = JSON.parse(response.body)

    expect(response).to be_success
    expect(merchant["id"]).to eq(merchant_list[1].id)
  end

  it "can get one merchant based on name" do
    merchant_list = create_list(:merchant, 10)

    get "/api/v1/merchants/find?name=#{merchant_list[3].name}"

    merchant = JSON.parse(response.body)

    expect(response).to be_success
    expect(merchant["id"]).to eq(merchant_list[3].id)
  end

  it "can get one merchant based on name (case-insensitive)" do
    skip
    merchant_list = create_list(:merchant, 10)

    get "/api/v1/merchants/find?name=#{merchant_list[3].name.upcase}"

    merchant = JSON.parse(response.body)

    expect(response).to be_success
    expect(merchant["id"]).to eq(merchant_list[3].id)
  end

  it "can get one merchant based on created_at" do
    skip
    merchant_list = create_list(:merchant, 10)

    get "/api/v1/merchants/find?created_at=#{merchant_list[5].created_at}"

    merchant = JSON.parse(response.body)

    expect(response).to be_success
    expect(merchant["id"]).to eq(merchant_list[5].id)
  end

  it "can get one merchant based on updated_at" do
    skip
    merchant_list = create_list(:merchant, 10)

    get "/api/v1/merchants/find?updated_at=#{merchant_list[7].updated_at}"

    merchant = JSON.parse(response.body)

    expect(response).to be_success
    expect(merchant["id"]).to eq(merchant_list[7].id)
  end

end
