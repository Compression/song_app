class Api

require "net/http"
require "json"
require "open-uri"
require 'wikipedia'


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
    @describe = []
    @recommended_genres.each do |x| #query for x, get result, process result, shovel into variable. (https://github.com/kenpratt/wikipedia-client)

      page = Wikipedia.find( '#{x}' )

      @describe << page.content

    end
    binding.pry
    print @describe
  end

end
