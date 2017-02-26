module TopRaters
  extend ActiveSupport::Concern

  def top_raters
    users.map(&:ratings.count)
  end
end