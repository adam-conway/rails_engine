require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe "validations" do
    it {should validate_presence_of(:name)}
    it {should have_many(:invoices)}
  end

  describe 'Field validations' do
    context 'invalid attributes' do
      it 'is invalid without a name' do
        merchant = Merchant.create()

        expect(merchant).to_not be_valid
      end
    end
    context 'valid attributes' do
      it 'is valid with all attributesß' do
        merchant = create(:merchant)

        expect(merchant).to be_valid
      end
    end
  end
end
