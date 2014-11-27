require "net/http"
require "json"
require "open-uri"
require 'wikipedia'

class Api
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
      genre_descriptions = describe(recommended_genres.take(3))
    else
      describe(['Polka','Waltz','Gangster Rap']) #this is in case it returns nothing
    end

  end

  def self.describe(genres)
    genre_descriptions = {}

    genres.each do |genre| #(https://github.com/kenpratt/wikipedia-client)
      page = Wikipedia.find(genre)
      genre_descriptions[genre] = ActionView::Base.full_sanitizer.sanitize(page.sanitized_content[0...300]).split(" ").first(200).join(" ") + "..."
    end

    # { "House music" => "description of house music", "Techno" => "description of techno", "Big beat" => "fhdajfdasfads" }

    genre_descriptions

  end
end
