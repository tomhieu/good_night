class FriendRelationship < ApplicationRecord
  belongs_to :requester, class_name: "User", foreign_key: :requester_id
  belongs_to :acceptor, class_name: "User", foreign_key: :acceptor_id

  validate :different_requester_and_acceptor

  private

  def different_requester_and_acceptor
    errors.add(:requester_id, "Cannot make friend with yourself") unless requester_id != acceptor_id
  end
end
