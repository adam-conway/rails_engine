class FavoriteMerchantSerializer < ActiveModel::Serializer
  attributes :favorite_merchant

  def favorite_merchant
    # require 'pry';binding.pry
    object.merchant_id
  end
end
