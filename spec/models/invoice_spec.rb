require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'validations' do
    it{should validate_presence_of(:status)}
  end

  describe 'field validations' do
    it 'should be invalid without a status' do
      invoice = Invoice.create

      expect(invoice).to_not be_valid
    end
  end
end
