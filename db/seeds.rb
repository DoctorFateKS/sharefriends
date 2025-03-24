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
  profile = Profile.create!(
    user: user,
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    mood: ["Fêtard", "Créatif", "L'explorateur", "Zen/Posé"].sample,
    hobbie: ["Geek/Créatif", "Sport/Découverte", "Food/Partage", "Chill/Cosy"].sample
  )
  file = URI.parse("https://res.cloudinary.com/dhixxvne7/image/upload/v1742486543/image_ztdqac.jpg").open
  profile.photo.attach(io: file, filename: "profile.jpg", content_type: "image/jpeg")
  profile.save
  users << user
end

event_data = [
  { title: "Concert Jazz & Soul", address: "New Morning, 7-9 Rue des Petites Écuries, 75010 Paris"},
  { title: "Conférence Tech & IA", address: "Station F, 5 Parvis Alan Turing, 75013 Paris"},
  { title: "Exposition d’Art Contemporain", address: "Centre Pompidou, Place Georges-Pompidou, 75004 Paris" },
  { title: "Atelier Cuisine Française", address: "L'Atelier des Chefs, 10 Rue de Penthièvre, 75008 Paris" },
  { title: "Soirée Stand-Up Comedy", address: "Paname Art Café, 14 Rue de la Fontaine au Roi, 75011 Paris" },
  { title: "Dégustation de Vins & Fromages", address: "Ô Chateau, 68 Rue Jean-Jacques Rousseau, 75001 Paris" },
  { title: "Balade Historique dans le Marais", address: "Place des Vosges, 75004 Paris" },
  { title: "Yoga au Jardin du Luxembourg", address: "Jardin du Luxembourg, 75006 Paris" },
  { title: "Hackathon Startups", address: "Espace WeWork, 33 Rue la Fayette, 75009 Paris" },
  { title: "Projection Film Indépendant", address: "Le Grand Rex, 1 Boulevard Poissonnière, 75002 Paris" }
]

# Création des événements pour chaque utilisateur
events = []

users.each do |user|
  3.times do |i|
    data = event_data.sample
    event = Event.create!(
      user: user,
      title: data[:title],
      description: Faker::Lorem.paragraph,
      address: data[:address],
      date: Faker::Time.forward(days: rand(10..60), period: :evening),
      mood: ["Fêtard", "Créatif", "L'explorateur", "Zen/Posé"].sample,
      status: ["pending", "accepted", "rejected"].sample,
      max_participants: rand(5..20),
      activity: ["Concert", "Conférence", "Exposition", "Atelier", "Spectacle", "Dégustation", "Balade", "Yoga", "Hackathon", "Projection"].sample,
      latitude: Faker::Address.latitude,
      longitude: Faker::Address.longitude
    )
    file = URI.parse("https://res.cloudinary.com/dhixxvne7/image/upload/v1742479415/240F306887089uWap0Lt9MBANoFTG4vrzqJytQW6RqFSajpg_6489afbf59a0a_z1oyy0.jpg").open
    event.photo.attach(io: file, filename: "event.jpg", content_type: "image/jpeg")
    event.save
    events << event

    # Création d'une chatroom pour chaque événement
    Chatroom.create!(event: event)
  end

  # Création de 5 participations aléatoires par utilisateur
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
