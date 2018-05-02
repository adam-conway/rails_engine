class Api::V1::Merchants::IntelligenceController < ApplicationController
  def show
    binding.pry
    render json: Merchant.find(params[:merchant_id])
  end
end
