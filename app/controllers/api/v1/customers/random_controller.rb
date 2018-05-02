class Api::V1::Customers::RandomController < ApplicationController

  def show
    params[:id] = rand(Customer.first.id..Customer.last.id)
    render json: Customer.find(params[:id])
  end

end
