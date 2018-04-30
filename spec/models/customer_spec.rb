require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe "validations" do
    it {should validate_presence_of(:first_name)}
    it {should validate_presence_of(:last_name)}
  end

  describe 'Field validations' do
    context 'invalid attributes' do
      it 'is invalid without a first name' do
        customer = Customer.create(
          last_name: "Conway"
        )

        expect(customer).to_not be_valid
      end
      it 'is invalid without a last name' do
        customer = Customer.create(
          first_name: "Adam"
        )

        expect(customer).to_not be_valid
      end
    end
    context 'valid attributes' do
      it 'is valid with all attributesß' do
        customer = Customer.create(
          first_name: "Adam",
          last_name: "Conway"
        )

        expect(customer).to be_valid
      end
    end
  end
end
