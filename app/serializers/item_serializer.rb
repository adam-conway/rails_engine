class ItemSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :merchant_id
  attribute  :unit_price
end
