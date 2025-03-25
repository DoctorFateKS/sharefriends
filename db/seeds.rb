require "open-uri"

# Clear all data
Message.destroy_all
Participation.destroy_all
Chatroom.destroy_all
Event.destroy_all
Profile.destroy_all
User.destroy_all

# Creation des users

user1 = User.create!(email: "laureline@lewagon.com", password: "password")
user2 = User.create!(email: "baptiste@lewagon.com", password: "password")
user3 = User.create!(email: "kevin@lewagon.com", password: "password")

# Creation des profils de chaque user

profile1 = Profile.create!(user: user1, first_name: "Laureline", last_name: "Desplanches", mood: "Fêtard", hobbie: "Sport-Aventure")
file1 = URI.parse('https://ca.slack-edge.com/T02NE0241-U089PLMCNA0-83fbccce4ffa-512').open
profile1.photo.attach(io: file1, filename: 'profile1.jpg', content_type: 'image/jpeg')
user1.save

profile2 = Profile.create!(user: user2, first_name: "Baptiste", last_name: "Casagrande", mood: "Créatif", hobbie: "Chill-Cosy")
file2 = URI.parse('https://ca.slack-edge.com/T02NE0241-U089HB880CV-086ce835c602-512').open
profile2.photo.attach(io: file2, filename: 'profile2.jpg', content_type: 'image/jpeg')
user2.save

profile3 = Profile.create!(user: user3, first_name: "Kevin", last_name: "Saison", mood: "Explorateur", hobbie: "Food-Partage")
file3 = URI.parse('https://ca.slack-edge.com/T02NE0241-U08AA2SGX24-e56e23ebdf92-512').open
profile3.photo.attach(io: file3, filename: 'profile3.jpg', content_type: 'image/jpeg')
user3.save

puts "Users: #{User.count}"
puts "Profiles: #{Profile.count}"

puts "Seeding complete!"
