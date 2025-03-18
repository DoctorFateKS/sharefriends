class Event < ApplicationRecord
  belongs_to :user
  has_one :chatroom, dependent: :destroy
end
