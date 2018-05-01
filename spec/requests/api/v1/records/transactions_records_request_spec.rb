require 'rails_helper'

describe "Transactions API" do

  it "sends a list of transactions" do
    transaction_list = create_list(:transaction, 3)

    get '/api/v1/transactions'

    expect(response).to be_success

    transactions = JSON.parse(response.body)

    expect(transactions.count).to eq(transaction_list.count)
  end

  it "can get one transaction by its id" do
    id = create(:transaction).id

    get "/api/v1/transactions/#{id}"

    transaction = JSON.parse(response.body)

    expect(response).to be_success
    expect(transaction["id"]).to eq(id)
  end

  describe "Single finders" do
    it "can get one transaction based on id" do
      transaction_list = create_list(:transaction, 10)

      get "/api/v1/transactions/find?id=#{transaction_list[1].id}"

      transaction = JSON.parse(response.body)

      expect(response).to be_success
      expect(transaction["id"]).to eq(transaction_list[1].id)
    end

    it "can get one transaction based on result" do
      transaction_list = create_list(:transaction, 10)

      get "/api/v1/transactions/find?result=#{transaction_list[0].result}"

      transaction = JSON.parse(response.body)

      expect(response).to be_success
      expect(transaction["id"]).to eq(transaction_list[0].id)
    end

    it "can get one transaction based on result (case-insensitive)" do
      transaction_list = create_list(:transaction, 10)

      get "/api/v1/transactions/find?result=#{transaction_list[0].result.upcase}"

      transaction = JSON.parse(response.body)

      expect(response).to be_success
      expect(transaction["id"]).to eq(transaction_list[0].id)
    end

    it "can get one transaction based on invoice id" do
      transaction_list = create_list(:transaction, 10)

      get "/api/v1/transactions/find?invoice_id=#{transaction_list[5].invoice_id}"

      transaction = JSON.parse(response.body)

      expect(response).to be_success
      expect(transaction["id"]).to eq(transaction_list[5].id)
    end

    it "can get one transaction based on credit card number" do
      transaction_list = create_list(:transaction, 10)

      get "/api/v1/transactions/find?credit_card_number=#{transaction_list[8].credit_card_number}"

      transaction = JSON.parse(response.body)

      expect(response).to be_success
      expect(transaction["id"]).to eq(transaction_list[8].id)
    end

    it "can get one transaction based on created_at" do
      date = "2018-04-30 10:45:00 UTC"
      transaction1 = create(:transaction, created_at: "2018-04-30 10:45:00 UTC")
      transaction2 = create(:transaction)
      transaction3 = create(:transaction)

      get "/api/v1/transactions/find?created_at=#{transaction1.created_at}"

      transaction = JSON.parse(response.body)

      expect(response).to be_success
      expect(transaction["id"]).to eq(transaction1.id)
    end

    it "can get one transaction based on updated_at" do
      date = "2018-04-30 10:45:00 UTC"
      transaction1 = create(:transaction)
      transaction2 = create(:transaction)
      transaction3 = create(:transaction, updated_at: date)

      get "/api/v1/transactions/find?updated_at=#{transaction3.updated_at}"

      transaction = JSON.parse(response.body)

      expect(response).to be_success
      expect(transaction["id"]).to eq(transaction3.id)
    end
  end

  describe "Multi finders" do
    it "can get all transactions based on id" do
      transaction_list = create_list(:transaction, 10)
      search_param = 1
      factory_transactions = transaction_list.find_all do |transaction|
        transaction.id == search_param
      end

      get "/api/v1/transactions/find_all?id=#{search_param}"

      response_transactions = JSON.parse(response.body)

      expect(response).to be_success
      expect(factory_transactions).to eq(response_transactions)
    end

    it "can get all transactions based on result" do
      transaction_list = create_list(:transaction, 10)
      search_param = "Success"
      factory_transactions = transaction_list.find_all do |transaction|
        transaction.result == search_param
      end

      get "/api/v1/transactions/find_all?result=#{search_param}"

      response_transactions = JSON.parse(response.body)

      expect(response).to be_success
      expect(factory_transactions).to eq(response_transactions)
    end

    it "can get all transactions based on invoice_id" do
      transaction_list = create_list(:transaction, 10)
      transaction_list << create(:transaction, invoice_id: transaction_list[0].invoice_id)

      factory_transactions = transaction_list.find_all do |transaction|
        transaction.invoice_id == transaction_list[0].invoice_id
      end

      get "/api/v1/transactions/find_all?invoice_id=#{transaction_list[0].invoice_id}"

      response_transactions = JSON.parse(response.body)

      expect(response).to be_success
      expect(response_transactions.count).to eq(factory_transactions.count)
      expect(factory_transactions.first.id).to eq(response_transactions.first["id"])
    end

    it "can get all transactions based on created_at" do
      date = "2018-04-30 10:45:00 UTC"
      transaction1 = create(:transaction, created_at: "2018-04-30 10:45:00 UTC")
      transaction2 = create(:transaction, created_at: "2018-04-30 10:45:00 UTC")
      transaction3 = create(:transaction)

      get "/api/v1/transactions/find_all?created_at=#{date}"

      transactions = JSON.parse(response.body)

      expect(response).to be_success
      expect(transactions.count).to eq(2)
      expect(transactions.first["id"]).to eq(transaction1.id)
      expect(transactions.last["id"]).to eq(transaction2.id)
    end

    it "can get all transactions based on updated_at" do
      date = "2018-04-30 10:45:00 UTC"
      transaction1 = create(:transaction)
      transaction2 = create(:transaction, updated_at: "2018-04-30 10:45:00 UTC")
      transaction3 = create(:transaction, updated_at: "2018-04-30 10:45:00 UTC")

      get "/api/v1/transactions/find_all?updated_at=#{date}"

      transactions = JSON.parse(response.body)

      expect(response).to be_success
      expect(transactions.count).to eq(2)
      expect(transactions.first["id"]).to eq(transaction2.id)
      expect(transactions.last["id"]).to eq(transaction3.id)
    end
  end
  it "Finds a random transaction" do
    transaction_list = create_list(:transaction, 10)

    get "/api/v1/transactions/random.json"

    transaction = JSON.parse(response.body)

    expect(response).to be_success
    expect(transaction_list.map(&:id).include?(transaction["id"]))
  end
end
