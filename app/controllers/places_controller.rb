# tämä rivi tarvitaan jotta api toimii herokussa ja tarvisissa
require 'beermapping_api'

class PlacesController < ApplicationController

  def index
  end

  def show
    @place = BeermappingApi.place_by_id(params[:id])
    @address = ERB::Util.url_encode("#{@place.street},#{@place.city}")
    @googleapikey = BeermappingApi.googleapikey
  end



  def new
    @place = Place.new
  end

  def create
    @place = Place.new(place.params)
    if @place.save
      render action: 'show'
    else
      redirect_to places_path, notice: "can't create place"
    end
  end

  def search
    @places = BeermappingApi.places_in(params[:city])
    if @places.empty?
      redirect_to places_path, notice: "No locations in #{params[:city]}"
    else
      render :index
    end
  end
end