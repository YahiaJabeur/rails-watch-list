# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'uri'
require 'net/http'
require 'json'

puts "Cleaning up database..."
Movie.destroy_all
puts "Database cleaned!"

# Fetch top-rated movies from the API
url = URI("https://tmdb.lewagon.com/movie/top_rated")
http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true

request = Net::HTTP::Get.new(url)
request["accept"] = 'application/json'

response = http.request(request)
movies = JSON.parse(response.read_body)["results"]

puts "Creating movies..."
movies.each do |movie_data|
  Movie.create!(
    title: movie_data["title"],
    overview: movie_data["overview"],
    poster_url: "https://image.tmdb.org/t/p/w500#{movie_data['poster_path']}",
    rating: movie_data["vote_average"]
  )
  puts "Created movie: #{movie_data['title']}"
end

puts "Seeding completed!"
