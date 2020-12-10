class ClockedTimeCreator < ApplicationService
  attr_reader :user_id, :action

  def initialize(user_id, action)
    @user_id = user_id
    @action = action
  end

  def call
    # assume that there's only one sleep record/day,
    # and sleeps don't last more than 12 hours
    current_sleep =
      Sleep.where(user_id: user_id)
      .where("created_at < ?", 12.hours.from_now)
      .first_or_create(user_id: user_id)

    ClockedTime.create(action: action, sleep_id: current_sleep.id)
  end
end