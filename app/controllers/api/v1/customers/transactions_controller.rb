class Api::V1::Customers::TransactionsController < ApplicationController
  def index
    require 'pry'; binding.pry
    render json: Customer.find(params[:customer_id]).transactions
  end
end
