class Api::V1::Transactions::RandomController < ApplicationController

  def show
    params[:id] = rand(Transaction.first.id..Transaction.last.id)
    render json: Transaction.find(params[:id])
  end

end
