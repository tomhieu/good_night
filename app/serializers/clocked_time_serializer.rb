class ClockedTimeSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :action
end
