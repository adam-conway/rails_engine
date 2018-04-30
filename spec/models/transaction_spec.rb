require 'rails_helper'

RSpec.describe Transaction, type: :model do
  describe "validations" do
    it {should validate_presence_of(:credit_card_number)}
    it {should validate_presence_of(:credit_card_expiration_date)}
    it {should validate_presence_of(:result)}
    it {should belong_to(:invoice)}
  end

  describe 'Field validations' do
    context 'invalid attributes' do
      it 'is invalid without a number' do
        transaction = Transaction.create(
          credit_card_expiration_date: 2343,
          result: "failed"
        )

        expect(transaction).to_not be_valid
      end
      it 'is invalid without an expiration' do
        transaction = Transaction.create(
          credit_card_number: 48585695,
          result: "failed"
        )

        expect(transaction).to_not be_valid
      end
      it 'is invalid without a result' do
        transaction = Transaction.create(
          credit_card_number: 48585695,
          credit_card_expiration_date: 2343
        )

        expect(transaction).to_not be_valid
      end
    end
    context 'valid attributes' do
      it 'is valid with all attributes' do
        transaction = create(:transaction)

        expect(transaction).to be_valid
      end
    end
  end
end
