class SleepFinder < ApplicationService
  attr_reader :user_id

  def initialize(user_id)
    @user_id = user_id
  end

  # return list of sleeps with ordered by their length (hours)
  def call
    friend_ids = FriendRelationship.confirmed.where(requester_id: user_id).pluck(:acceptor_id)
    friend_ids += FriendRelationship.confirmed.where(acceptor_id: user_id).pluck(:requester_id)
    Sleep
      .joins("join clocked_times as go_to_bed_times on go_to_bed_times.sleep_id = sleeps.id AND go_to_bed_times.action = 'go_to_bed'")
      .joins("join clocked_times as wake_up_times on wake_up_times.sleep_id = sleeps.id AND wake_up_times.action = 'wake_up'")
      .where(user_id: friend_ids)
      .select("sleeps.id as id, sleeps.user_id as user_id,
        ((julianday(wake_up_times.created_at) - julianday(go_to_bed_times.created_at))*24) as length
      ")
      .order(:length)
  end
end