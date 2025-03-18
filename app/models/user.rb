class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :profile, dependent: :destroy
  has_many :hosted_events, dependent: :destroy, class_name: "Event"
  has_many :participations, dependent: :destroy
  has_many :pending_events, -> { where(participations: { status: "pending" })}, through: :participations, source: :event
  has_many :accepted_events, -> { where(participations: { status: "accepted" })}, through: :participations, source: :event
  has_many :rejected_events, -> { where(participations: { status: "rejected" })}, through: :participations, source: :event
  has_many :messages, dependent: :destroy

  delegate :first_name, :last_name, :mood, :hobbie, to: :profile
end
