require "http"
require "json"

pp "Where are you located"

user_location = gets.chomp.gsub(" ", "%20")
# user_location = "Chicago"

pp user_location

maps_url = "https://maps.googleapis.com/maps/api/geocode/json?address=" + user_location + "&key=" + ENV.fetch("GMAPS_KEY")

resp = HTTP.get(maps_url)

raw_response = resp.to_s

parsed_response = JSON.parse(raw_response)


lat =  parsed_response.fetch("results")[0].fetch("geometry").fetch("location").fetch("lat")
lng =  parsed_response.fetch("results")[0].fetch("geometry").fetch("location").fetch("lng")


pirate_weather_api_key = ENV.fetch("PIRATE_WEATHER_KEY")

pirate_weather_url = "https://api.pirateweather.net/forecast/" + pirate_weather_api_key + "/" + lat.to_s + "," + lng.to_s #"/41.8887,-87.6355"

raw_response = HTTP.get(pirate_weather_url)

parsed_response = JSON.parse(raw_response)

currently_hash = parsed_response.fetch("currently")

current_temp = currently_hash.fetch("temperature")

puts "The current temperature is " + current_temp.to_s + "."
