# Imports the Google Cloud client library
#Buttercup family", Scarlet oak
require "google/cloud/vision"
# Instantiates a client
vision = Google::Cloud::Vision

# The name of the image file to annotate
file_name = '/Users/RA/flatiron/code/plantae_api/db/pl_pile_pepe_6_inch_po_cer_white_704x1024.jpg'
binding.pry
# Performs label detection on the image file
response = vision.image_annotator.label_detection image: file_name
binding.pry
response.responses.each do |res|
  puts "Labels:"
  res.label_annotations.each do |label|
    puts label.description
  end
end
