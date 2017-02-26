module RatingAverage
  extend ActiveSupport::Concern

  def average_rating
    return unless ratings.count.to_f > 0
      ratings.map(&:score).inject(&:+)/ratings.count.to_f
    end
  end
