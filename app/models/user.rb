class User < ActiveRecord::Base
  include RatingAverage

  has_secure_password

  has_many :ratings
  has_many :memberships
  has_many :beer_clubs, through: :memberships
  has_many :beers, through: :ratings

  validates :username, uniqueness: true,
                        length: {minimum: 3, maximum: 30 }

  validates :beer_clubs, uniqueness: true

end


