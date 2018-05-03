class Api::V1::Customers::FavoriteMerchantController < ApplicationController
  def show
    # require 'pry';binding.pry
    render json: Customer.find(params["customer_id"]).favorite_merchant, serializer: MerchantSerializer
  end
end
