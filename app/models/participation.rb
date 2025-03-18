class Participation < ApplicationRecord
  belongs_to :user
  belongs_to :event

  enum :status, {pending: "pending", accepted: "accepted", rejected: "rejected"}
end
