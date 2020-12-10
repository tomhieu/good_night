class SleepSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :length
end
