class Place < OpenStruct
  def self.rendered_fields
    [ :id, :name, :status, :street, :city, :zip, :country, :overall ]
  end
  def search
    api_key = "e6b4d14d58acccd3397568e8d2605e98"
    url = "http://beermapping.com/webservice/loccity/#{api_key}/"
    response = HTTParty.get "#{url}#{ERB::Util.url_encode(params[:city])}"

    @places = response.parsed_response["bmp_locations"]["location"].map do | place |
      Place.new(place)
    end

    render :index
  end
end