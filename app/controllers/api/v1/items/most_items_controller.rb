class Api::V1::Items::MostItemsController < ApplicationController
  def show
    # require 'pry';binding.pry
    render json: Item.most_sold_items(params["quantity"])
  end
end
