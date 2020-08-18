require "google/cloud/vision"
require 'rest-client'
require 'json'

class Api::V1::IdentifierController < ApplicationController
skip_before_action :authorized, only: [:getImageId]

  def getImageId
    # Instantiates a client
    image_annotator = Google::Cloud::Vision.image_annotator

    # The name of the image file to annotate
    file_name = "#{params[:imagePath]}"
    response = {}
    descriptions = []
    # Performs label detection on the image file
    vision_response = image_annotator.label_detection image: file_name
    vision_response.responses.each do |res|
      res.label_annotations.each do |label|
      p label
      descriptions.push("#{label.description}")

      end
    end

    plants = []

    descriptions.each do |desc|
      trefleresponse = RestClient.get("https://trefle.io/api/v1/plants/search?token=#{ENV["TREFLE_API_KEY"]}&q=#{desc}")
      data = JSON.parse(trefleresponse)
        if data["data"].length > 0
         plants.push(data["data"])
       end

      end

    response["descriptions"] = descriptions

    response["plants"] = plants
    render json: response
  end

end
