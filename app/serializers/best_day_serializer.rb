class BestDaySerializer < ActiveModel::Serializer
  attributes :best_day

  def best_day
    object.best_day
  end
end
