describe 'Transactions API' do
  describe 'relationships' do
    it 'can return invoice associated with a transaction' do
      create(:transaction)
      transaction_id = Transaction.last.id
      invoice_id = Transaction.last.invoice.id
      get "/api/v1/transactions/#{transaction_id}/invoice"

      invoice = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoice["id"]).to eq(invoice_id)
    end
  end
end
