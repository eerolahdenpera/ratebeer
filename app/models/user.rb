class User < ActiveRecord::Base
  include RatingAverage

  has_secure_password

  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings

  has_many :memberships, dependent: :destroy
  has_many :beer_clubs, through: :memberships

  validates :username, uniqueness: true,
            length: { minimum: 3, maximum: 30 }
  validates :password, length: { minimum: 4 }
  validates :password, format: { with: /([A-Z].*\d)|(\d.*[A-Z].*)/,
                                 message: "should contain one number and one capital letter" }


  def number_of_ratings
    ratings.count
  end

  def favorite_beer
    return nil if ratings.empty?
    ratings.order(score: :desc).limit(1).first.beer
  end

  def blocked
    unless blocked? nil?
      false
    else
      blocked?
    end
  end

end