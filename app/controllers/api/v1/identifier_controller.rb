require "google/cloud/vision"
require 'rest-client'
require 'json'

class Api::V1::IdentifierController < ApplicationController
skip_before_action :authorized, only: [:getImageId]
  def getImageId
    p request.body.read
    p "okoko"
    key = {
        api_key: ENV['PLANTID'],
        images: params[:imagePath],
        modifiers: ["crops_fast", "similar_images"],
        plant_language: "en",
        plant_details: ["common_names",
                          "url",
                          "name_authority",
                          "wiki_description",
                          "taxonomy",
                          "synonyms"]
      }

response = RestClient.post("https://api.plant.id/v2/identify", key, {content_type: :json, accept: :json})
data = JSON.parse(response)

p
render json: data
  end

end
