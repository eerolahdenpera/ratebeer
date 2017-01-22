class Beer < ActiveRecord::Base
	belongs_to :brewery
	has_many :ratings

	def average_rating
		arr = []
		ratings.each do |rating|
			arr.push(rating.score)
		end
		average = sprintf "%.2f", arr.inject(0.0) { |sum, el| sum + el } / arr.size
		"#{average}"
	end

end
