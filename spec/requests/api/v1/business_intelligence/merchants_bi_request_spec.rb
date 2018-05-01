require 'rails_helper'

describe "Merchants API" do

  it "sends a list of merchants" do
    merchant_list = create_list(:merchant, 10)
    merchant_list.each do |merchant|
      5.times do
        invoice = create(:invoice, merchant_id: merchant.id)
        3.times do
          create(:invoice_item, invoice_id: invoice.id)
        end
      end
    end

    get '/api/v1/merchants'

    expect(response).to be_success

    merchants = JSON.parse(response.body)
  end
end
