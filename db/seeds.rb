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
# def mach_sport(sport_nl)
#   if sport_nl == "VOETBAL"
#     return "Foot"
#   elsif sport_nl == "OVERIG"
#     return "Others"
#   elsif sport_nl == "JEUDEBOULES"
#     return "Petanque"
#   elsif sport_nl == "TAFELTENNIS"
#     return "Ping pong"
#   elsif sport_nl == "BASKETBAL"
#     return "Basketball"
#   end
#   return sport_nl.downcase.capitalize
# end
# puts "Seeding start"

# puts "------- Destroying All activities -------"
# Activity.destroy_all
# User.destroy_all
# Sport.destroy_all
# puts "--------- Creating users -------"

# # ----------- users seeding -------
# lucas = User.new(username: "lucas.silva", first_name: "lucas", last_name: "silva", email: "lucas@gmail.com", password: "testtest")
# lucas.save
# puts "#{lucas.username} created"

# musa = User.new(username: "ahmed.musa", first_name: "ahmed", last_name: "musa", email: "ahmed@gmail.com", password: "testtest")
# musa.save
# puts "#{musa.username} created"

# tom = User.new(username: "tom.borg", first_name: "tom", last_name: "borg", email: "tom@gmail.com", password: "testtest")
# tom.save
# puts "#{tom.username} created"

# theo = User.new(username: "theo.comlan", first_name: "theo", last_name: "comlan", email: "theo@gmail.com", password: "testtest")
# theo.save
# puts "#{theo.username} created"

# 5.times do
#   user = User.create!(username: Faker::Internet.username,
#                       first_name: Faker::Name.first_name,
#                       last_name: Faker::Name.last_name,
#                       email: Faker::Internet.email,
#                       password: "testtest")
#   user.save
#   puts "#{user.username} created"
# end

# # ----------- sports seeding -------
# puts "------- Creating Sports -------"
# sports = ["Basketball", "Tennis", "Foot", "Others", "Skate", "Fitness", "Petanque", "Ping pong"]
# sports.each do |sport|
#   if ["Basketball", "Tennis", "Foot", "Petanque", "Ping pong"].include?(sport)
#     the_sport = Sport.create!(name: sport, category: "Ball")
#   else
#     the_sport = Sport.create!(name: sport, category: sport)
#   end
#   the_sport.save
#   puts "#{the_sport.name} create"
# end

# puts "------- Creating Activities -------"
# # ----------- activities seeding -------
# # ----API to get the sport field of amsterdam -----
# uri = URI.parse("https://maps.amsterdam.nl/open_geodata/geojson_lnglat.php?KAARTLAAG=SPORT_OPENBAAR&THEMA=sport")
# response = Net::HTTP.get_response(uri)
# data = JSON.parse(response.body)
# all_activities = data['features']
# # selectie = ["BASKETBAL", "TENNIS", "VOETBAL", "OVERIG", "SKATE", "FITNESS", "JEUDEBOULES", "TAFELTENNIS"]
# 25.times do
#   index = rand(0..950)
#   the_activity = all_activities[index]
#   while (the_activity == nil) || (the_activity["properties"]["Omschrijving"] == "") || (the_activity["properties"]["SÉLECTIE"] == "")
#     index = rand(0..950)
#     the_activity = all_activities[index]
#   end

#   lat = the_activity['geometry']['coordinates'][1]
#   lng = the_activity['geometry']['coordinates'][0]
#   # ----- generate random sentense for name -----
#   game_type = ['match', 'tournament', 'league', 'season', 'training', 'championship', 'competition', 'game']
#   level = ["beginner", "intermediate", "advanced", "pro", "recreational"]
#   type = ["3x3", "4x4", "5x5", "1vs1", "11x11"]
#   the_sport = mach_sport(the_activity["properties"]["SELECTIE"])
#   sentence = "#{type.sample} #{the_sport} #{game_type.sample} for #{level.sample} "
#   # ---- another API to get the location address -----
#   uri = URI.parse("https://nominatim.openstreetmap.org/reverse?format=json&lat=#{lat}&lon=#{lng}")
#   response = Net::HTTP.get_response(uri)
#   the_location = JSON.parse(response.body)
#   address = the_location["display_name"]
#   desc = "#{type.sample} #{the_sport} #{game_type.sample} for #{level.sample}. #{the_activity['properties']['Omschrijving']}. #{Faker::Lorem.paragraph}"

#   activity = Activity.create!(name: sentence,
#                               user: User.all.sample,
#                               sport: Sport.find_by(name: the_sport),
#                               location: address,
#                               description: desc,
#                               date_time: Faker::Date.between(from: Date.today, to: 1.week.from_now))
#   activity.save
#   puts "#{activity.name} create"
# end

# puts "Finished!"







######################################################################################################################
######################################################################################################################
#--------------------------------- SEED ATTEMPT 1 with AI ----------------------------------
######################################################################################################################
######################################################################################################################




# client = OpenAI::Client.new

# puts "Starting Seed"

# puts "------- Cleaning Database -------"
# Activity.destroy_all
# User.destroy_all
# Sport.destroy_all
# puts "-------- Database Cleaned --------"
# puts "--------- Creating Users ---------"

# # ----------- Dev Seeds ----------
# lucas = User.new(username: "lucas.silva", first_name: "lucas", last_name: "silva", email: "lucas@gmail.com", password: "testtest")
# lucas.save
# puts "#{lucas.username} created"

# musa = User.new(username: "ahmed.musa", first_name: "ahmed", last_name: "musa", email: "ahmed@gmail.com", password: "testtest")
# musa.save
# puts "#{musa.username} created"

# tom = User.new(username: "tom.borg", first_name: "tom", last_name: "borg", email: "tom@gmail.com", password: "testtest")
# tom.save
# puts "#{tom.username} created"

# theo = User.new(username: "theo.comlan", first_name: "theo", last_name: "comlan", email: "theo@gmail.com", password: "testtest")
# theo.save
# puts "#{theo.username} created"


# # ----------- User Seeds ----------
# 5.times do
#   chatgpt_response = client.chat(parameters: {
#     model: "gpt-3.5-turbo",
#     messages: [{ role: "user", content: "Choose a random given name from the internet, uncommon or common. Your response should only be one word, all lowercase."}]
#   })
#   first_name = chatgpt_response["choices"][0]["message"]["content"]

#   chatgpt_response = client.chat(parameters: {
#     model: "gpt-3.5-turbo",
#     messages: [{ role: "user", content: "Choose a random surname from the internet, uncommon or common. Your response should only be one word, all lowercase."}]
#   })
#   last_name = chatgpt_response["choices"][0]["message"]["content"]

#   user = User.new(username: "#{first_name}.#{last_name}",
#                       first_name: first_name,
#                       last_name: last_name,
#                       email: "#{first_name}.#{last_name}@gmail.com",
#                       password: "testtest")
#   user.save
#   puts "#{user.username} created"
# end

# puts "------- Creating Sports -------"
# sports = ["Football", "Basketball", "Cricket", "Tennis", "Baseball", "Rugby", "Golf", "Ice Hockey", "Table Tennis", "Volleyball"]
# sports.each do |sport|
#   if ["Cricket", "Football", "Rugby", "Baseball", "Tennis", "Golf"].include?(sport)
#     the_sport = Sport.new(name: sport, category: "Outdoor")
#   else
#     the_sport = Sport.new(name: sport, category: "Indoor")
#   end
#   the_sport.save!
#   puts "#{the_sport.name} created"
# end

# puts "------- Creating Activities -------"
# 25.times do
#   client = OpenAI::Client.new
#   sport = Sport.all.sample

# # ----- Generate Random Address -----
#   chatgpt_response = client.chat(parameters: {
#     model: "gpt-3.5-turbo",
#     messages: [{ role: "user", content: "Select a random local #{sport} venue that is open to the public in Amsterdam and give me the address. The response should only include the address with no description"}]
#   })
#   address = chatgpt_response["choices"][0]["message"]["content"]

#   chatgpt_response = client.chat(parameters: {
#     model: "gpt-3.5-turbo",
#     messages: [{ role: "user", content: "Give me the latitude for #{address}"}]
#   })
#   latitude = chatgpt_response["choices"][0]["message"]["content"]

#   chatgpt_response = client.chat(parameters: {
#     model: "gpt-3.5-turbo",
#     messages: [{ role: "user", content: "Give me the longitude for #{address}"}]
#   })
#   longitude = chatgpt_response["choices"][0]["message"]["content"]

#   chatgpt_response = client.chat(parameters: {
#     model: "gpt-3.5-turbo",
#     messages: [{ role: "user", content: "Based on this address: #{address}, returning the suburb only (no postcode), without your own description or explaination. The suburb should be more specific than Amsterdam, e.g. Joordan, Amsterdam-Zuid, Nieuw-West"}]
#   })
#   suburb = chatgpt_response["choices"][0]["message"]["content"]

#   # ----- Generate Random Sentence -----
#   # levels = ["Beginner", "Intermediate", "Advanced", "Pro", "Recreational"]
#   type = ["1 vs 1", "2 vs 2", "3 vs 3", "4 vs 4", "5 vs 5", "11 vs 11"]
#   activity_name = "#{type.sample} #{sport.name} in #{suburb}"

#   chatgpt_response = client.chat(parameters: {
#     model: "gpt-3.5-turbo",
#     messages: [{ role: "user", content: "Write a brief description of a post that is looking for extra players to join a #{activity_name} game at #{address} (only include the name of the suburb). The description should be at least 80 characters but no more than 320. Only return the description and not your own explaination. "}]
#   })
#   description = chatgpt_response["choices"][0]["message"]["content"]

#   # ----- Generate Random Time -----
#   chatgpt_response = client.chat(parameters: {
#     model: "gpt-3.5-turbo",
#     messages: [{ role: "user", content: "Generate a random time and day the next 2 weeks between 7am and 10pm. it needs to be in the following format: YYYY-MM-DDTHH:MM. It should be to the nearest 15 minutes and your response should only included the response in the requested format without any of your own explaination."}]
#   })
#   time = chatgpt_response["choices"][0]["message"]["content"]

#   sport_id = sport[:id]
#   activity = Activity.create!(name: activity_name,
#     user: User.all.sample,
#     sport: Sport.find(sport_id),
#     location: address,
#     description: description,
#     latitude: latitude,
#     longitude: longitude,
#     date_time: time)
#   puts "#{activity.name} created"
# end



######################################################################################################################
######################################################################################################################
#--------------------------------- SEED ATTEMPT 2 ----------------------------------
######################################################################################################################
######################################################################################################################




# def mach_sport(sport_nl)
#   if sport_nl == "VOETBAL"
#     return "Foot"
#   elsif sport_nl == "OVERIG"
#     return "Others"
#   elsif sport_nl == "JEUDEBOULES"
#     return "Petanque"
#   elsif sport_nl == "TAFELTENNIS"
#     return "Ping pong"
#   elsif sport_nl == "BASKETBAL"
#     return "Basketball"
#   end
#   return sport_nl.downcase.capitalize
# end
# puts "Seeding start"

# puts "------- Destroying All activities -------"
# Activity.destroy_all
# User.destroy_all
# Sport.destroy_all
# puts "--------- Creating users -------"

# # ----------- User Seeding -------
# users = [
#   { username: "lucas.silva", first_name: "lucas", last_name: "silva", email: "lucas@gmail.com", password: "testtest" },
#   { username: "ahmed.musa", first_name: "ahmed", last_name: "musa", email: "ahmed@gmail.com", password: "testtest" },
#   { username: "tom.borg", first_name: "tom", last_name: "borg", email: "tom@gmail.com", password: "testtest" },
#   { username: "theo.comlan", first_name: "theo", last_name: "comlan", email: "theo@gmail.com", password: "testtest" },
#   { username: "julia.rodriguez", first_name: "julia", last_name: "rodriguez", email: "julia@gmail.com", password: "testtest" },
#   { username: "kwame.okafor", first_name: "kwame", last_name: "okafor", email: "kwame@gmail.com", password: "testtest" },
#   { username: "mei.chen", first_name: "mei", last_name: "chen", email: "mei@gmail.com", password: "testtest" },
#   { username: "arjun.iyer", first_name: "arjun", last_name: "iyer", email: "arjun@gmail.com", password: "testtest" },
#   { username: "yumi.kim", first_name: "yumi", last_name: "kim", email: "yumi@gmail.com", password: "testtest" },
#   { username: "raj.patel", first_name: "raj", last_name: "patel", email: "raj@gmail.com", password: "testtest" },
#   { username: "luisa.alvarez", first_name: "luisa", last_name: "alvarez", email: "luisa@gmail.com", password: "testtest" },
#   { username: "chinedu.nwosu", first_name: "chinedu", last_name: "nwosu", email: "chinedu@gmail.com", password: "testtest" },
#   { username: "hana.matsumoto", first_name: "hana", last_name: "matsumoto", email: "hana@gmail.com", password: "testtest" },
#   { username: "rodrigo.fernandez", first_name: "rodrigo", last_name: "fernandez", email: "rodrigo@gmail.com", password: "testtest" },
#   { username: "david.garcia", first_name: "david", last_name: "garcia", email: "david@gmail.com", password: "testtest" },
#   { username: "olivia.brown", first_name: "olivia", last_name: "brown", email: "olivia@gmail.com", password: "testtest" },
#   { username: "michael.wilson", first_name: "michael", last_name: "wilson", email: "michael@gmail.com", password: "testtest" },
#   { username: "isabella.moore", first_name: "isabella", last_name: "moore", email: "isabella@gmail.com", password: "testtest" },
#   { username: "william.taylor", first_name: "william", last_name: "taylor", email: "william@gmail.com", password: "testtest" }
# ]

# users.each do |user|
#   User.create(user)
#   puts "#{user[:username]} created"
# end

# # ----------- Sports Seed -------

# sports = [
#   { name: "Soccer", category: "Team", image_url: "https://res.cloudinary.com/demo/image/upload/v1622497997/soccer.jpg" },
#   { name: "Basketball", category: "Team", image_url: "https://res.cloudinary.com/demo/image/upload/v1622497997/basketball.jpg" },
#   { name: "Baseball", category: "Team", image_url: "https://res.cloudinary.com/demo/image/upload/v1622497997/baseball.jpg" },
#   { name: "Tennis", category: "Individual", image_url: "https://res.cloudinary.com/demo/image/upload/v1622497997/tennis.jpg" },
#   { name: "Volleyball", category: "Team", image_url: "https://res.cloudinary.com/demo/image/upload/v1622497997/volleyball.jpg" },
#   { name: "Cricket", category: "Team", image_url: "https://res.cloudinary.com/demo/image/upload/v1622497997/cricket.jpg" },
#   { name: "Rugby", category: "Team", image_url: "https://res.cloudinary.com/demo/image/upload/v1622497997/rugby.jpg" },
#   { name: "Hockey", category: "Team", image_url: "https://res.cloudinary.com/demo/image/upload/v1622497997/hockey.jpg" },
#   { name: "Golf", category: "Individual", image_url: "https://res.cloudinary.com/demo/image/upload/v1622497997/golf.jpg" },
#   { name: "Swimming", category: "Individual", image_url: "https://res.cloudinary.com/demo/image/upload/v1622497997/swimming.jpg" },
#   { name: "Cycling", category: "Individual", image_url: "https://res.cloudinary.com/demo/image/upload/v1622497997/cycling.jpg" },
#   { name: "Boxing", category: "Individual", image_url: "https://res.cloudinary.com/demo/image/upload/v1622497997/boxing.jpg" },
#   { name: "Wrestling", category: "Individual", image_url: "https://res.cloudinary.com/demo/image/upload/v1622497997/wrestling.jpg" },
#   { name: "Tennis", category: "Individual", image_url: "https://res.cloudinary.com/demo/image/upload/v1622497997/tennis.jpg" },
#   { name: "Badminton", category: "Individual", image_url: "https://res.cloudinary.com/demo/image/upload/v1622497997/badminton.jpg" },
#   { name: "Table Tennis", category: "Individual", image_url: "https://res.cloudinary.com/demo/image/upload/v1622497997/table_tennis.jpg" },
#   { name: "Basketball", category: "Team", image_url: "https://res.cloudinary.com/demo/image/upload/v1622497997/basketball.jpg" },
#   { name: "American Football", category: "Team", image_url: "https://res.cloudinary.com/demo/image/upload/v1622497997/american_football.jpg" },
#   { name: "Softball", category: "Team", image_url: "https://res.cloudinary.com/demo/image/upload/v1622497997/softball.jpg" },
#   { name: "Handball", category: "Team", image_url: "https://res.cloudinary.com/demo/image/upload/v1622497997/handball.jpg" }
# ]

# sports.each do |sport|
#   Sport.create(sport)
#   puts "#{sport[:name]} created"
# end


# puts "------- Creating Activities -------"
# # ----------- activities seeding -------
# # ----API to get the sport field of amsterdam -----
# uri = URI.parse("https://maps.amsterdam.nl/open_geodata/geojson_lnglat.php?KAARTLAAG=SPORT_OPENBAAR&THEMA=sport")
# response = Net::HTTP.get_response(uri)
# data = JSON.parse(response.body)
# all_activities = data['features']
# # selectie = ["BASKETBAL", "TENNIS", "VOETBAL", "OVERIG", "SKATE", "FITNESS", "JEUDEBOULES", "TAFELTENNIS"]
# 25.times do
#   index = rand(0..950)
#   the_activity = all_activities[index]
#   while (the_activity == nil) || (the_activity["properties"]["Omschrijving"] == "") || (the_activity["properties"]["SÉLECTIE"] == "")
#     index = rand(0..950)
#     the_activity = all_activities[index]
#   end

#   lat = the_activity['geometry']['coordinates'][1]
#   lng = the_activity['geometry']['coordinates'][0]
#   # ----- generate random sentense for name -----
#   game_type = ['match', 'tournament', 'league', 'season', 'training', 'championship', 'competition', 'game']
#   level = ["beginner", "intermediate", "advanced", "pro", "recreational"]
#   type = ["3 vs 3", "4 vs 4", "5 vs 5", "1 vs 1", "11 vs 11"]
#   the_sport = (mach_sport)(the_activity["properties"]["SELECTIE"])
#   sentence = "#{type.sample} #{the_sport} #{game_type.sample} for #{level.sample} "
#   # ---- another API to get the location address -----
#   uri = URI.parse("https://nominatim.openstreetmap.org/reverse?format=json&lat=#{lat}&lon=#{lng}")
#   response = Net::HTTP.get_response(uri)
#   the_location = JSON.parse(response.body)
#   address = the_location["display_name"]
#   desc = "#{type.sample} #{the_sport} #{game_type.sample} for #{level.sample}. #{the_activity['properties']['Omschrijving']}. #{Faker::Lorem.paragraph}"

#   activity = Activity.create!(name: sentence,
#                               user: User.all.sample,
#                               sport: Sport.find_by(name: the_sport),
#                               location: address,
#                               description: desc,
#                               date_time: Faker::Date.between(from: Date.today, to: 1.week.from_now))
#   activity.save
#   puts "#{activity.name} create"
# end

# puts "Finished!"







######################################################################################################################
######################################################################################################################
#--------------------------------- SEED ATTEMPT 3 ----------------------------------
######################################################################################################################
######################################################################################################################







puts "Seeding start"

puts "------- Destroying All activities -------"
Activity.destroy_all
User.destroy_all
Sport.destroy_all
puts "--------- Creating users -------"

# ----------- users seeding -------
users = [
  { username: "lucas.silva", first_name: "lucas", last_name: "silva", email: "lucas@gmail.com", password: "testtest" },
  { username: "ahmed.musa", first_name: "ahmed", last_name: "musa", email: "ahmed@gmail.com", password: "testtest" },
  { username: "tom.borg", first_name: "tom", last_name: "borg", email: "tom@gmail.com", password: "testtest" },
  { username: "theo.comlan", first_name: "theo", last_name: "comlan", email: "theo@gmail.com", password: "testtest" },
  { username: "julia.rodriguez", first_name: "julia", last_name: "rodriguez", email: "julia@gmail.com", password: "testtest" },
  { username: "kwame.okafor", first_name: "kwame", last_name: "okafor", email: "kwame@gmail.com", password: "testtest" },
  { username: "mei.chen", first_name: "mei", last_name: "chen", email: "mei@gmail.com", password: "testtest" },
  { username: "arjun.iyer", first_name: "arjun", last_name: "iyer", email: "arjun@gmail.com", password: "testtest" },
  { username: "yumi.kim", first_name: "yumi", last_name: "kim", email: "yumi@gmail.com", password: "testtest" },
  { username: "raj.patel", first_name: "raj", last_name: "patel", email: "raj@gmail.com", password: "testtest" },
  { username: "luisa.alvarez", first_name: "luisa", last_name: "alvarez", email: "luisa@gmail.com", password: "testtest" },
  { username: "chinedu.nwosu", first_name: "chinedu", last_name: "nwosu", email: "chinedu@gmail.com", password: "testtest" },
  { username: "hana.matsumoto", first_name: "hana", last_name: "matsumoto", email: "hana@gmail.com", password: "testtest" },
  { username: "rodrigo.fernandez", first_name: "rodrigo", last_name: "fernandez", email: "rodrigo@gmail.com", password: "testtest" },
  { username: "david.garcia", first_name: "david", last_name: "garcia", email: "david@gmail.com", password: "testtest" },
  { username: "olivia.brown", first_name: "olivia", last_name: "brown", email: "olivia@gmail.com", password: "testtest" },
  { username: "michael.wilson", first_name: "michael", last_name: "wilson", email: "michael@gmail.com", password: "testtest" },
  { username: "isabella.moore", first_name: "isabella", last_name: "moore", email: "isabella@gmail.com", password: "testtest" },
  { username: "william.taylor", first_name: "william", last_name: "taylor", email: "william@gmail.com", password: "testtest" }
]

users.each do |user|
  User.create(user)
  puts "#{user[:username]} created"
end

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

# ----------- sports seeding -------
puts "------- Creating Sports -------"
sports = [
  { name: "Soccer", category: "Team", image_url: "https://res.cloudinary.com/demo/image/upload/v1622497997/soccer.jpg" },
  { name: "Basketball", category: "Team", image_url: "https://res.cloudinary.com/demo/image/upload/v1622497997/basketball.jpg" },
  { name: "Baseball", category: "Team", image_url: "https://res.cloudinary.com/demo/image/upload/v1622497997/baseball.jpg" },
  { name: "Tennis", category: "Individual", image_url: "https://res.cloudinary.com/demo/image/upload/v1622497997/tennis.jpg" },
  { name: "Volleyball", category: "Team", image_url: "https://res.cloudinary.com/demo/image/upload/v1622497997/volleyball.jpg" },
  { name: "Cricket", category: "Team", image_url: "https://res.cloudinary.com/demo/image/upload/v1622497997/cricket.jpg" },
  { name: "Rugby", category: "Team", image_url: "https://res.cloudinary.com/demo/image/upload/v1622497997/rugby.jpg" },
  { name: "Hockey", category: "Team", image_url: "https://res.cloudinary.com/demo/image/upload/v1622497997/hockey.jpg" },
  { name: "Golf", category: "Individual", image_url: "https://res.cloudinary.com/demo/image/upload/v1622497997/golf.jpg" },
  { name: "Swimming", category: "Individual", image_url: "https://res.cloudinary.com/demo/image/upload/v1622497997/swimming.jpg" },
  { name: "Cycling", category: "Individual", image_url: "https://res.cloudinary.com/demo/image/upload/v1622497997/cycling.jpg" },
  { name: "Boxing", category: "Individual", image_url: "https://res.cloudinary.com/demo/image/upload/v1622497997/boxing.jpg" },
  { name: "Wrestling", category: "Individual", image_url: "https://res.cloudinary.com/demo/image/upload/v1622497997/wrestling.jpg" },
  { name: "Tennis", category: "Individual", image_url: "https://res.cloudinary.com/demo/image/upload/v1622497997/tennis.jpg" },
  { name: "Badminton", category: "Individual", image_url: "https://res.cloudinary.com/demo/image/upload/v1622497997/badminton.jpg" },
  { name: "Table Tennis", category: "Individual", image_url: "https://res.cloudinary.com/demo/image/upload/v1622497997/table_tennis.jpg" },
  { name: "Basketball", category: "Team", image_url: "https://res.cloudinary.com/demo/image/upload/v1622497997/basketball.jpg" },
  { name: "American Football", category: "Team", image_url: "https://res.cloudinary.com/demo/image/upload/v1622497997/american_football.jpg" },
  { name: "Softball", category: "Team", image_url: "https://res.cloudinary.com/demo/image/upload/v1622497997/softball.jpg" },
  { name: "Handball", category: "Team", image_url: "https://res.cloudinary.com/demo/image/upload/v1622497997/handball.jpg" }
]

sports.each do |sport|
  new_sport = Sport.create!(sport)

  # file = URI.open(sport[:image_url])
  # new_sport.photo.attach(io: file, filename: "#{sport}.jpg", content_type: "image/jpg")
  # new_sport.save

  puts "#{sport[:name]} created"
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
  # game_type = ['match', 'tournament', 'league', 'season', 'training', 'championship', 'competition', 'game']
  # level = ["beginner", "intermediate", "advanced", "pro", "recreational"]
  type = ["3 vs 3", "4 vs 4", "5 vs 5", "1 vs 1", "11 vs 11"]

  # ---- Random Sport from the array -----
  randomSportIndex = rand(0..sports.size - 1)
  the_sport = sports[randomSportIndex][:name]

  sentence = "#{type.sample} #{the_sport}"
  # 3 vs 3 Basketball match for advanced
  # 3 vs 3 beginners Basketball match

  # ---- another API to get the location address -----
  uri = URI.parse("https://nominatim.openstreetmap.org/reverse?format=json&lat=#{lat}&lon=#{lng}")
  response = Net::HTTP.get_response(uri)
  the_location = JSON.parse(response.body)
  address = the_location["display_name"]

# ----- generate random description using openAI -----
  client = OpenAI::Client.new
  chatgpt_response = client.chat(parameters: {
    model: "gpt-3.5-turbo",
    messages: [{ role: "user", content: "Write a brief description of a post that is looking for extra players to join a #{sentence} game at #{address} (only include the name of the suburb). The description should be at least 80 characters but no more than 320. Only return the description and not your own explaination. "}]
  })

  desc = chatgpt_response["choices"][0]["message"]["content"]



  sport = Sport.find_by(name: the_sport)
  date_time = Faker::Time.between_dates(from: DateTime.now, to: 1.week.from_now, period: :day)
  # Faker::Time.between_dates(from: Date.today - 1, to: Date.today, period: :day)
  puts "Date Time: #{date_time}"

  activity = Activity.create!(name: sentence,
                              user: User.all.sample,
                              sport: sport,
                              location: address,
                              description: desc,
                              date_time: date_time)
                              # date_time: Faker::Date.between(from: Date.today, to: 1.week.from_now))
  activity.save
  puts "#{activity.name} create"
end

puts "Finished!"
