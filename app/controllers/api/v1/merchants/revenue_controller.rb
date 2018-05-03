class Api::V1::Merchants::RevenueController < ApplicationController
  def show
    render json: Merchant.find(params["merchant_id"]).single_merchant_revenue, serializer: MerchantRevenueSerializer
  end
end
