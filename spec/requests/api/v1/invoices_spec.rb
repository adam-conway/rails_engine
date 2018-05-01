require 'rails_helper'

describe 'Invoices API' do
  it 'returns index of invoices' do
    create_list(:invoice, 2)

    get '/api/v1/invoices.json'

    invoices = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoices.count).to eq(2)
  end

  it 'returns a single invoice' do
    create(:invoice)
    invoice_id = Invoice.last.id

    get "/api/v1/invoices/#{invoice_id}"

    invoice = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice["id"]).to eq(invoice_id)
  end
end
