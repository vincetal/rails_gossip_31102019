# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'
Faker::Config.locale = 'fr'

=begin
#Création des villes

10.times do
  City.create(name: Faker::Address.city, zip_code: Faker::Address.postcode)
end

#Création de users

10.times do
  User.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, description: Faker::Lorem.paragraph, email: Faker::Internet.email, age: rand(18..99), city_id: City.all.sample.id)
end



#Création de gossips

20.times do
  Gossip.create(title: Faker::Book.title, content: Faker::Books::Dune.quote, user_id: User.all.sample.id)
end



#Création de Tags

10.times do
  Tag.create(title: Faker::Verb.past)
end

#Attribuer des tags à des gossips (chaque gossip peut avoir jusque 4 tags)
Gossip.all.each do |my_gossip|

  rand(1..4).times do
    JoinTableGossipTag.create(tag_id: Tag.all.sample.id, gossip_id: my_gossip.id)
  end

end


#Création de private_messages  (un user a envoyé entre 0 et 5 messages (les destinataires de chaque messages entre 1 et 5))

User.all.each do |my_user|

  rand(0..5).times do
    #création du message
    m = PrivateMessage.create(content: Faker::TvShows::GameOfThrones.quote, sender_id: User.all.sample.id )
    #Choix des destiantaires
    rand(1..5) do
      JoinTableMessageRecipient.create(recipient_id: User.all.sample.id, private_message_id: m.id)
    end

  end

end


#Attribuer des commentaires à des gossips (chaque gossip peut avoir jusque 4 commentaires)
Gossip.all.each do |my_gossip|

  rand(0..4).times do
    Comment.create(gossip_id: my_gossip.id, content: Faker::TvShows::HowIMetYourMother.quote)
  end

end
=end
