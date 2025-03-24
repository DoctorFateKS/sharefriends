class Profile < ApplicationRecord
  belongs_to :user
  has_one_attached :photo
  def hobbies
    hobbie.to_s.split(',').map(&:strip)
  end
end
