class Api

require "net/http"
require "json"
require "open-uri"

  def self.recommend(name)
  api_key = ENV["ECHO_NEST_KEY"]

  uri = URI("http://developer.echonest.com/api/v4/artist/similar?api_key=#{api_key}&name=#{URI::encode(name)}&format=json&results=5&start=0")
  response = Net::HTTP.get(uri)
  hash = JSON.parse(response)

  artists = hash["response"]["artists"].map{|artist| artist["name"]}

  uri = URI("http://developer.echonest.com/api/v4/artist/terms?api_key=#{api_key}&name=#{URI::encode(artists.sample)}&format=json")
  response = Net::HTTP.get(uri)
  hash = JSON.parse(response)

  if hash["response"]["terms"]
    recommended_genres = hash["response"]["terms"].map{|gen| gen["name"]}
  else
    recommended_genres = [1,2,3]
  end

  @recommended_genres = recommended_genres.take(3)

  end

  def self.describe(genre)
    genre = @recommended_genres.each
    uri = URI("http://en.wikipedia.org/w/api.php?format=json&action=query&titles=Main%20Page&prop=revisions&rvprop=content")
    response = Net::HTTP.get(uri)
    hash = JSON.parse(response)

    describe = hash
    binding.pry
  end
end
