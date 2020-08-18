require 'rest-client'
require 'json'

class Api::V1::PlantsController < ApplicationController
   skip_before_action :authorized
def index
  p request.headers["currentPage"]
  p params

  response = RestClient.get("https://trefle.io/api/v1/plants?token=#{ENV["TREFLE_API_KEY"]}&page=#{request.headers["currentPage"]}")
  data = JSON.parse(response)
  render json: {
    "data": data,
    "currentPage": request.headers["currentPage"]
  }
  end

  def flowers
    response = RestClient.get("https://trefle.io/api/v1/plants/search?token=#{ENV["TREFLE_API_KEY"]}&page=#{request.headers["currentPage"]}&q=flower")
    data = JSON.parse(response)
    render json: {
      "data": data,
      "currentPage": request.headers["currentPage"]
    }
  end

  def food
    response = RestClient.get("https://trefle.io/api/v1/plants?token=#{ENV["TREFLE_API_KEY"]}&page=#{request.headers["currentPage"]}&filter[edible_part]=roots,stem,leaves,flowers,fruits,seeds")
    data = JSON.parse(response)
    render json: {
      "data": data,
      "currentPage": request.headers["currentPage"]
    }
  end

  def getImage

   response = RestClient.get("https://pixabay.com/api/?key=#{ENV["PIX_API_KEY"]}&q=flower&image_type=photo&pretty=true&per_page=25")
   data = JSON.parse(response)

   render json: {
     "data": data
   }
  end

  def show
   response = RestClient.get("https://trefle.io/api/v1/plants/#{params["id"]}?token=#{ENV["TREFLE_API_KEY"]}")
   data = JSON.parse(response)

   render json: {
     "data": data
   }
  end

  def userplants
     if params["userplants"].length > 0
    scientific_names = params["userplants"].map { |p| p["scientific_name"] }
    scientific_names = scientific_names.join(",")
    else
      scientific_names = params["userplants"][0]
    end

    request.headers["userplants"]

   response = RestClient.get("https://trefle.io/api/v1/plants?token=#{ENV["TREFLE_API_KEY"]}&filter[scientific_name]=#{scientific_names}")
   data = JSON.parse(response)

   render json: {
     "data": data
   }
  end

private

 def pants_params
   params.require(:plant).permit!
 end

end
