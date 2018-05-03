class FavoriteMerchantSerializer < ActiveModel::Serializer
  attributes :favorite_merchant

  def favorite_merchant
    object.merchant_id
  end
end
