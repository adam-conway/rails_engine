class Api::V1::Merchants::RandomController < ApplicationController

  def show
    params[:id] = rand(Merchant.first.id..Merchant.last.id)
    render json: Merchant.find(params[:id])
  end

end
