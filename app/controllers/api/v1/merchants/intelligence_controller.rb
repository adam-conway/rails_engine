class Api::V1::Merchants::IntelligenceController < ApplicationController
  def show
    render json: Merchant.find(params[:merchant_id])
  end
end
