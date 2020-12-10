class FriendRelationship < ApplicationRecord
  belongs_to :requester, class_name: "User", foreign_key: :requester_id
  belongs_to :acceptor, class_name: "User", foreign_key: :acceptor_id

  validate :uniqueness_of_relationship, on: :create
  validate :different_requester_and_acceptor

  scope :confirmed, -> {where(confirmed: true)}

  private

  def uniqueness_of_relationship
    already_exists = FriendRelationship.where("\
      (requester_id = :first_user AND acceptor_id = :second_user) OR  \
      (requester_id = :second_user AND acceptor_id = :first_user)",
      first_user: requester_id,
      second_user: acceptor_id
    ).exists?

    errors.add(:requester_id, "already requested") if already_exists
  end

  def different_requester_and_acceptor
    errors.add(:requester_id, "Cannot make friend with yourself") unless requester_id != acceptor_id
  end
end
