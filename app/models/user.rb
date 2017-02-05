class User < ActiveRecord::Base
  include RatingAverage

  has_secure_password

  has_many :ratings
  has_many :memberships
  has_many :beer_clubs, through: :memberships
  has_many :beers, through: :ratings

  validates :username, uniqueness: true,
                        length: { minimum: 3, maximum: 30 }
  validates :password, length: { minimum: 4 },
            format: {with: /\d/, message: "must contain atleast one digit."},
            :on => :create

  def has_uppercase
    password_digest.upcase?
  end

end


