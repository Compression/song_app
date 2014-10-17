class Api

require "net/http"
require "json"
require "open-uri"

  def self.recommend(name)
  api_key = ENV["ECHO_NEST_KEY"]

  uri = URI("http://developer.echonest.com/api/v4/artist/similar?api_key=0BIOUDHLRGSIO0MHC&name=#{URI::encode(name)}&format=json&results=3&start=0")
  response = Net::HTTP.get(uri)
  hash = JSON.parse(response)

  artists = hash["response"]["artists"].map{|artist| artist["name"]}

  uri = URI("http://developer.echonest.com/api/v4/artist/terms?api_key=0BIOUDHLRGSIO0MHC&name=#{URI::encode(artists.sample)}&format=json")
  response = Net::HTTP.get(uri)
  hash = JSON.parse(response)

  recommended_genres = hash["response"]["terms"].map{|gen| gen["name"]}

  recommended_genres.take(3)

  end
end
