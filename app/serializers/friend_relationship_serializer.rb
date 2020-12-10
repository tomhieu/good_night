class FriendRelationshipSerializer < ActiveModel::Serializer
  attributes :id, :requester_id, :acceptor_id, :confirmed
end
