require 'rails_helper'

describe "Customers API" do

  it "sends a list of customers" do
    customer_list = create_list(:customer, 3)

    get '/api/v1/customers'

    expect(response).to be_success

    customers = JSON.parse(response.body)

    expect(customers.count).to eq(customer_list.count)
  end

  it "can get one customer by its id" do
    id = create(:customer).id

    get "/api/v1/customers/#{id}"

    customer = JSON.parse(response.body)

    expect(response).to be_success
    expect(customer["id"]).to eq(id)
  end
  describe "Single finders" do
    it "can get one customer based on id" do
      customer_list = create_list(:customer, 10)

      get "/api/v1/customers/find?id=#{customer_list[1].id}"

      customer = JSON.parse(response.body)

      expect(response).to be_success
      expect(customer["id"]).to eq(customer_list[1].id)
    end

    it "can get one customer based on first name" do
      customer_list = create_list(:customer, 10)

      get "/api/v1/customers/find?first_name=#{customer_list[3].first_name}"

      customer = JSON.parse(response.body)

      expect(response).to be_success
      expect(customer["id"]).to eq(customer_list[3].id)
    end

    it "can get one customer based on first name (case-insensitive)" do
      customer_list = create_list(:customer, 10)

      get "/api/v1/customers/find?first_name=#{customer_list[3].first_name.upcase}"

      customer = JSON.parse(response.body)

      expect(response).to be_success
      expect(customer["id"]).to eq(customer_list[3].id)
    end

    it "can get one customer based on last name" do
      customer_list = create_list(:customer, 10)

      get "/api/v1/customers/find?last_name=#{customer_list[0].last_name}"

      customer = JSON.parse(response.body)

      expect(response).to be_success
      expect(customer["id"]).to eq(customer_list[0].id)
    end

    it "can get one customer based on first name (case-insensitive)" do
      customer_list = create_list(:customer, 10)

      get "/api/v1/customers/find?last_name=#{customer_list[3].last_name.upcase}"

      customer = JSON.parse(response.body)

      expect(response).to be_success
      expect(customer["id"]).to eq(customer_list[3].id)
    end

    it "can get one customer based on created_at" do
      date = "2018-04-30 10:45:00 UTC"
      customer1 = create(:customer, created_at: "2018-04-30 10:45:00 UTC")
      customer2 = create(:customer)
      customer3 = create(:customer)

      get "/api/v1/customers/find?created_at=#{customer1.created_at}"

      customer = JSON.parse(response.body)

      expect(response).to be_success
      expect(customer["id"]).to eq(customer1.id)
    end

    it "can get one customer based on updated_at" do
      date = "2018-04-30 10:45:00 UTC"
      customer1 = create(:customer, updated_at: date)
      customer2 = create(:customer)
      customer3 = create(:customer)

      get "/api/v1/customers/find?updated_at=#{customer1.updated_at}"

      customer = JSON.parse(response.body)

      expect(response).to be_success
      expect(customer["id"]).to eq(customer1.id)
    end
  end
  describe "Multi finders" do
    it "can get all customers based on id" do
      customer_list = create_list(:customer, 10)
      search_param = 1
      factory_customers = customer_list.find_all do |customer|
        customer.id == search_param
      end

      get "/api/v1/customers/find_all?id=#{search_param}"

      response_customers = JSON.parse(response.body)

      expect(response).to be_success
      expect(factory_customers).to eq(response_customers)
    end

    it "can get all customers based on first name" do
      customer_list = create_list(:customer, 10)
      customer_list << create(:customer, first_name: customer_list[0].first_name)

      factory_customers = customer_list.find_all do |customer|
        customer.first_name == customer_list[0].first_name
      end

      get "/api/v1/customers/find_all?first_name=#{customer_list[0].first_name}"

      response_customers = JSON.parse(response.body)

      expect(response).to be_success
      expect(response_customers.count).to eq(factory_customers.count)
      expect(factory_customers.first.id).to eq(response_customers.first["id"])
    end

    it "can get all customers based on last name" do
      customer_list = create_list(:customer, 10)
      customer_list << create(:customer, last_name: customer_list[0].last_name)

      factory_customers = customer_list.find_all do |customer|
        customer.last_name == customer_list[0].last_name
      end

      get "/api/v1/customers/find_all?last_name=#{customer_list[0].last_name}"

      response_customers = JSON.parse(response.body)

      expect(response).to be_success
      expect(response_customers.count).to eq(factory_customers.count)
      expect(factory_customers.first.id).to eq(response_customers.first["id"])
    end

    it "can get all customers based on created_at" do
      date = "2018-04-30 10:45:00 UTC"
      customer1 = create(:customer, created_at: "2018-04-30 10:45:00 UTC")
      customer2 = create(:customer, created_at: "2018-04-30 10:45:00 UTC")
      customer3 = create(:customer)

      get "/api/v1/customers/find_all?created_at=#{date}"

      customers = JSON.parse(response.body)

      expect(response).to be_success
      expect(customers.count).to eq(2)
      expect(customers.first["id"]).to eq(customer1.id)
      expect(customers.last["id"]).to eq(customer2.id)
    end

    it "can get all customers based on updated_at" do
      date = "2018-04-30 10:45:00 UTC"
      customer1 = create(:customer, updated_at: "2018-04-30 10:45:00 UTC")
      customer2 = create(:customer, updated_at: "2018-04-30 10:45:00 UTC")
      customer3 = create(:customer)

      get "/api/v1/customers/find_all?updated_at=#{date}"

      customers = JSON.parse(response.body)

      expect(response).to be_success
      expect(customers.count).to eq(2)
      expect(customers.first["id"]).to eq(customer1.id)
      expect(customers.last["id"]).to eq(customer2.id)
    end
  end
  it "Finds a random customer" do
    customer_list = create_list(:customer, 10)

    get "/api/v1/customers/random.json"

    customer = JSON.parse(response.body)

    expect(response).to be_success
    expect(customer_list.map(&:id).include?(customer["id"]))
  end
end
