require 'rails_helper'

describe 'Invoices API' do
  it 'returns index of invoices' do
    create_list(:invoice, 2)

    get '/api/v1/invoices.json'

    invoices = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoices.count).to eq(2)
  end
end
