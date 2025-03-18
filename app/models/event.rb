class Event < ApplicationRecord
  belongs_to :user
  has_one :chatroom, dependent: :destroy
  has_many :participations, dependent: :destroy
end
