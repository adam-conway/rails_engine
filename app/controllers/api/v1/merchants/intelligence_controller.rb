class Api::V1::Merchants::IntelligenceController < ApplicationController
  def show
    render json: Merchant.find(params["merchant_id"]).intelligence_router(request, params)
  end
end
