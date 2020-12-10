class ClockedTime < ApplicationRecord
  belongs_to :sleep

  ACTIONS = ["go_to_bed", "wake_up"].freeze

  validates :action, inclusion: ACTIONS
end
