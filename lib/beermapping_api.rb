class BeermappingApi
  def self.places_in(city)
    city = city.downcase
    Rails.cache.fetch(city, expires_in: 168.hours) { fetch_places_in(city) } #168 tuntia = 7 päivää = viikko
  end

  def self.place_by_id(id)
    Rails.cache.fetch("place_id_#{id}", expires_in: 7.days) { fetch_by_id(id) }
  end

  def self.fetch_places_in(city)
    url = "http://beermapping.com/webservice/loccity/#{key}/"

    response = HTTParty.get "#{url}#{ERB::Util.url_encode(city)}"
    places = response.parsed_response["bmp_locations"]["location"]

    return [] if places.is_a?(Hash) and places['id'].nil?

    places = [places] if places.is_a?(Hash)
    places.map do | place |
      Place.new(place)
    end
  end

  def self.fetch_by_id(id)
    url = "http://beermapping.com/webservice/locquery/#{key}/"

    response = HTTParty.get "#{url}#{ERB::Util.url_encode(id)}"
    place = response.parsed_response["bmp_locations"]["location"]

    return [] if place.is_a?(Hash) and place['id'].nil?

    Place.new(place)

  end

  def self.key
    raise "APIKEY env variable not defined" if ENV['APIKEY'].nil?
    ENV['APIKEY']
  end

  def self.googleapikey
    raise "GOOGLEAPIKEY env variable not defined" if ENV['GOOGLEAPIKEY'].nil?
    ENV['GOOGLEAPIKEY']
  end
end