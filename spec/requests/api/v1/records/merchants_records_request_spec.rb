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
  describe "Single finders" do
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
      merchant_list = create_list(:merchant, 10)

      get "/api/v1/merchants/find?name=#{merchant_list[3].name.upcase}"

      merchant = JSON.parse(response.body)

      expect(response).to be_success
      expect(merchant["id"]).to eq(merchant_list[3].id)
    end

    it "can get one merchant based on created_at" do
      date = "2018-04-30 10:45:00 UTC"
      merchant1 = create(:merchant, created_at: "2018-04-30 10:45:00 UTC")
      merchant2 = create(:merchant)
      merchant3 = create(:merchant)

      get "/api/v1/merchants/find?created_at=#{merchant1.created_at}"

      merchant = JSON.parse(response.body)

      expect(response).to be_success
      expect(merchant["id"]).to eq(merchant1.id)
    end

    it "can get one merchant based on updated_at" do
      date = "2018-04-30 10:45:00 UTC"
      merchant1 = create(:merchant, updated_at: date)
      merchant2 = create(:merchant)
      merchant3 = create(:merchant)

      get "/api/v1/merchants/find?updated_at=#{merchant1.updated_at}"

      merchant = JSON.parse(response.body)

      expect(response).to be_success
      expect(merchant["id"]).to eq(merchant1.id)
    end
  end
  describe "Multi finders" do
    it "can get all merchants based on id" do
      merchant_list = create_list(:merchant, 10)
      search_param = 1
      factory_merchants = merchant_list.find_all do |merchant|
        merchant.id == search_param
      end

      get "/api/v1/merchants/find_all?id=#{search_param}"

      response_merchants = JSON.parse(response.body)

      expect(response).to be_success
      expect(factory_merchants).to eq(response_merchants)
    end

    it "can get all merchants based on name" do
      merchant_list = create_list(:merchant, 10)
      merchant_list << create(:merchant, name: merchant_list[0].name)

      factory_merchants = merchant_list.find_all do |merchant|
        merchant.name == merchant_list[0].name
      end

      get "/api/v1/merchants/find_all?name=#{merchant_list[0].name}"

      response_merchants = JSON.parse(response.body)

      expect(response).to be_success
      expect(factory_merchants).to eq(response_merchants)
    end

    #
    # it "can get one merchant based on name (case-insensitive)" do
    #   skip
    #   merchant_list = create_list(:merchant, 10)
    #
    #   get "/api/v1/merchants/find?name=#{merchant_list[3].name.upcase}"
    #
    #   merchant = JSON.parse(response.body)
    #
    #   expect(response).to be_success
    #   expect(merchant["id"]).to eq(merchant_list[3].id)
    # end
    #
    # it "can get one merchant based on created_at" do
    #   date = "2018-04-30 10:45:00 UTC"
    #   merchant1 = create(:merchant, created_at: "2018-04-30 10:45:00 UTC")
    #   merchant2 = create(:merchant)
    #   merchant3 = create(:merchant)
    #
    #   get "/api/v1/merchants/find?created_at=#{merchant1.created_at}"
    #
    #   merchant = JSON.parse(response.body)
    #
    #   expect(response).to be_success
    #   expect(merchant["id"]).to eq(merchant1.id)
    # end
    #
    # it "can get one merchant based on updated_at" do
    #   date = "2018-04-30 10:45:00 UTC"
    #   merchant1 = create(:merchant, updated_at: date)
    #   merchant2 = create(:merchant)
    #   merchant3 = create(:merchant)
    #
    #   get "/api/v1/merchants/find?updated_at=#{merchant1.updated_at}"
    #
    #   merchant = JSON.parse(response.body)
    #
    #   expect(response).to be_success
    #   expect(merchant["id"]).to eq(merchant1.id)
    # end
  end
end
