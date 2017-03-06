class BreweriesController < ApplicationController
  before_action :set_brewery, only: [:show, :edit, :update, :destroy]
  before_action :ensure_that_signed_in, except: [:index, :show]


  def list

  end
  # GET /breweries
  # GET /breweries.json
  def index
    @active_breweries = Brewery.active
    @retired_breweries = Brewery.retired
    @breweries = Brewery.all

    if params[:order] == 'name' && session[:order] == 'name'
      order = 'name_reverse'
    else if  params[:order] == 'name' && session[:order] == 'name_reverse'
           order = 'name'
    else if params[:order] == 'year' && session[:order] == 'year'
           order = 'year_reverse'
    else if params[:order] == 'year' && session[:order] == 'year_reverse'
           order = 'year'
    else
      order = params[:order] || 'name'
         end
           end
    end
    end

    #byebug

    session[:order] = order


    @active_breweries = case order
      when 'name' then @active_breweries.sort_by{ |brewery| brewery.name }
      when 'year' then @active_breweries.sort_by{ |brewery| brewery.year }
      when 'name_reverse' then @active_breweries.sort_by{ |brewery| brewery.name }.reverse
      when 'year_reverse' then @active_breweries.sort_by{ |brewery| brewery.year }.reverse
    end
    @retired_breweries = case order
     when 'name' then @retired_breweries.sort_by{ |brewery| brewery.name }
     when 'year' then @retired_breweries.sort_by{ |brewery| brewery.year }
     when 'name_reverse' then @retired_breweries.sort_by{ |brewery| brewery.name }.reverse
     when 'year_reverse' then @retired_breweries.sort_by{ |brewery| brewery.year }.reverse
   end
  end

  # GET /breweries/1
  # GET /breweries/1.json
  def show
  end

  # GET /breweries/new
  def new
    @brewery = Brewery.new
  end

  # GET /breweries/1/edit
  def edit
  end

  # POST /breweries
  # POST /breweries.json
  def create
    @brewery = Brewery.new(brewery_params)

    respond_to do |format|
      if @brewery.save
        format.html { redirect_to @brewery, notice: 'Brewery was successfully created.' }
        format.json { render :show, status: :created, location: @brewery }
      else
        format.html { render :new }
        format.json { render json: @brewery.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /breweries/1
  # PATCH/PUT /breweries/1.json
  def update
    respond_to do |format|
      if @brewery.update(brewery_params)
        format.html { redirect_to @brewery, notice: 'Brewery was successfully updated.' }
        format.json { render :show, status: :ok, location: @brewery }
      else
        format.html { render :edit }
        format.json { render json: @brewery.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /breweries/1
  # DELETE /breweries/1.json
  def destroy
    if current_user.admin
      @brewery.destroy
      respond_to do |format|
        format.html { redirect_to breweries_url, notice: 'Brewery was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      redirect_to :back, notice: 'Only admins can destroy breweries'
    end
  end

  def toggle_activity
    brewery = Brewery.find(params[:id])
    brewery.update_attribute :active, (not brewery.active)

    new_status = brewery.active? ? "active" : "retired"

    redirect_to :back, notice:"brewery activity status changed to #{new_status}"
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_brewery
    @brewery = Brewery.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def brewery_params
    params.require(:brewery).permit(:name, :year, :active)
  end


end