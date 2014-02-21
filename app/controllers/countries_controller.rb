class CountriesController < ApplicationController

def index
    @countries = Country.all
    h = {}
    @countries.each do |country|
      h[country.map_id] = [
        country.name,
        country.searches,
      ]
    end

    respond_to do |format|
      format.html
      format.json do 
        render json: h.to_json
      end
    end

end

def create
end

def show
end

def edit
end

def update
end

def get_country_data
  map_id = params["map_id"]
  country = Country.find_by_map_id(map_id)
  redirect_to country_path(country)
end

end