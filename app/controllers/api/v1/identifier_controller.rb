require "google/cloud/vision"
require 'rest-client'
require 'json'

class Api::V1::IdentifierController < ApplicationController
skip_before_action :authorized, only: [:getImageId]

  def getImageId
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

response = RestClient::Request.execute(method: :post,
                            url: 'https://api.plant.id/v2/identify',
                            payload: key,
                            headers: {"Content-Type" => "application/json"}
                           )
data = JSON.parse(response)

p response
p data
render json: data
  end

end
