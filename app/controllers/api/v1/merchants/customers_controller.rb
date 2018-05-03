class Api::V1::Merchants::CustomersController < ApplicationController
  def show
    render json: Merchant.find(params[:merchant_id]).favorite_customer
  end

  def index
    render json: Merchant.find(params[:merchant_id]).customers_with_pending_invoices
  end
end
