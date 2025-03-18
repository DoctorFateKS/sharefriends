# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'faker'
Faker::Config.locale = 'fr'

# Clear all data
Message.destroy_all
Participation.destroy_all
Chatroom.destroy_all
Event.destroy_all
Profile.destroy_all
User.destroy_all

# Creation de 10 users aléatoire
users = []
10.times do |i|
  # Creation d'un user avec un email unique et un mot de passe "password"
  user = User.create!(
    email: "sharefriends#{i+1}@example.com",
    password: "password"
  )
  # Creation d'un profile pour chaque user avec des informations aléatoires
  Profile.create!(
    user: user,
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    mood: ["Fêtard", "Créatif", "L'explorateur", "Zen/Posé"].sample,
    hobbie: ["Geek/Créatif", "Sport/Découverte", "Food/Partage", "Chill/Cosy"].sample
  )
  users << user
end

# Create events
events = []
# Pour chaque user, on crée 3 events
users.each do |user|
  3.times do |i|
    event = Event.create!(
      user: user,
      title: "titre de l'event #{i+1}",
      description: Faker::Lorem.paragraph,
      address: Faker::Address.street_address,
      date: Faker::Time.forward(days: 30, period: :evening),
      mood: ["Fêtard", "Créatif", "L'explorateur", "Zen/Posé"].sample,
      status: ["pending", "accepted", "rejected"].sample,
      max_participants: rand(5..20),
      activity: Faker::Sport.sport,
      latitude: Faker::Address.latitude,
      longitude: Faker::Address.longitude
    )
    events << event
    # On crée un chatroom pour chaque event
    Chatroom.create!(event: event)
  end
  # On crée 5 participations pour chaque user
  events.sample(5).each do |event|
    Participation.create!(
      user: user,
      event: event,
      status: ["pending", "accepted", "rejected"].sample
    )
  end
end

# Create messages
Chatroom.find_each do |chatroom|
  # Pour chaque chatroom, on crée entre 5 et 15 messages
  rand(5..15).times do
    Message.create!(
      user: users.sample,
      chatroom: chatroom,
      content: Faker::Lorem.sentence
    )
  end
end

puts "Users: #{User.count}"
puts "Profiles: #{Profile.count}"
puts "Events: #{Event.count}"
puts "Chatrooms: #{Chatroom.count}"
puts "Participations: #{Participation.count}"
puts "Messages: #{Message.count}"

puts "Seeding complete!"
