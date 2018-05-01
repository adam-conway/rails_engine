class TransactionSerializer < ActiveModel::Serializer
  attributes :credit_card_number, :id, :invoice_id, :result

  def credit_card_number
    object.credit_card_number.to_s
  end
end
