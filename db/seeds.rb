require 'net/http'
require 'uri'
require 'json'
# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
def mach_sport(sport_nl)
  if sport_nl == "VOETBAL"
    return "Foot"
  elsif sport_nl == "OVERIG"
    return "Others"
  elsif sport_nl == "JEUDEBOULES"
    return "Petanque"
  elsif sport_nl == "TAFELTENNIS"
    return "Ping pong"
  elsif sport_nl == "BASKETBAL"
    return "Basketball"
  end
  return sport_nl.downcase.capitalize
end
puts "Seeding start"

puts "------- Destroying All activities -------"
Activity.destroy_all
User.destroy_all
Sport.destroy_all
puts "--------- Creating users -------"

# ----------- users seeding -------
lucas = User.create!(username: "lucas", first_name: "lucas", last_name: "Silva", email: "lucas@test.test", password: "testtest")
lucas.save
puts "#{lucas.first_name} create"

musa = User.create!(username: "musa", first_name: "ahmed", last_name: "Musa", email: "musa@test.test", password: "testtest")
musa.save
puts "#{musa.first_name} create"

tom = User.create!(username: "tom", first_name: "tom", last_name: "Borg", email: "tom@test.test", password: "testtest")
tom.save
puts "#{tom.first_name} create"

theo = User.create!(username: "theo", first_name: "theo", last_name: "Comlan", email: "theo@test.test", password: "testtest")
theo.save
puts "#{theo.first_name} create"

5.times do
  user = User.create!(username: Faker::Internet.username,
                      first_name: Faker::Name.first_name,
                      last_name: Faker::Name.last_name,
                      email: Faker::Internet.email,
                      password: "testtest")
  user.save
  puts "#{user.username} create"
end

# ----------- sports seeding -------
puts "------- Creating Sports -------"
sports = ["Basketball", "Tennis", "Foot", "Others", "Skate", "Fitness", "Petanque", "Ping pong"]
sports.each do |sport|
  if ["Basketball", "Tennis", "Foot", "Petanque", "Ping pong"].include?(sport)
    the_sport = Sport.create!(name: sport, category: "Ball")
  else
    the_sport = Sport.create!(name: sport, category: sport)
  end
  the_sport.save
  puts "#{the_sport.name} create"
end

puts "------- Creating Activities -------"
# ----------- activities seeding -------
# ----API to get the sport field of amsterdam -----
uri = URI.parse("https://maps.amsterdam.nl/open_geodata/geojson_lnglat.php?KAARTLAAG=SPORT_OPENBAAR&THEMA=sport")
response = Net::HTTP.get_response(uri)
data = JSON.parse(response.body)
all_activities = data['features']
# selectie = ["BASKETBAL", "TENNIS", "VOETBAL", "OVERIG", "SKATE", "FITNESS", "JEUDEBOULES", "TAFELTENNIS"]
25.times do
  index = rand(0..950)
  the_activity = all_activities[index]
  while (the_activity == nil) || (the_activity["properties"]["Omschrijving"] == "") || (the_activity["properties"]["SÉLECTIE"] == "")
    index = rand(0..950)
    the_activity = all_activities[index]
  end

  lat = the_activity['geometry']['coordinates'][1]
  lng = the_activity['geometry']['coordinates'][0]
  # ----- generate random sentense for name -----
  game_type = ['match', 'tournament', 'league', 'season', 'training', 'championship', 'competition', 'game']
  level = ["beginner", "intermediate", "advanced", "pro", "recreational"]
  type = ["3x3", "4x4", "5x5", "1vs1", "11x11"]
  the_sport = mach_sport(the_activity["properties"]["SELECTIE"])
  sentence = "#{type.sample} #{the_sport} #{game_type.sample} for #{level.sample} "
  # ---- another API to get the location address -----
  uri = URI.parse("https://nominatim.openstreetmap.org/reverse?format=json&lat=#{lat}&lon=#{lng}")
  response = Net::HTTP.get_response(uri)
  the_location = JSON.parse(response.body)
  address = the_location["display_name"]
  desc = "#{type.sample} #{the_sport} #{game_type.sample} for #{level.sample}. #{the_activity['properties']['Omschrijving']}. #{Faker::Lorem.paragraph}"

  activity = Activity.create!(name: sentence,
                              user: User.all.sample,
                              sport: Sport.find_by(name: the_sport),
                              location: address,
                              description: desc,
                              date_time: Faker::Date.between(from: Date.today, to: 1.week.from_now))
  activity.save
  puts "#{activity.name} create"
end

puts "Finished!"
