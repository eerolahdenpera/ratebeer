class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :beer_club

  validates :user_id, presence: true
  validates :beer_club_id, presence: true

  validates_uniqueness_of :user_id, :scope => :beer_club_id
end
