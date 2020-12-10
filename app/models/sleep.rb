class Sleep < ApplicationRecord
  belongs_to :user
  has_many :clocked_times
end
