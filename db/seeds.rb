require 'yelp'
require 'faker'

client = Yelp::Client.new({ consumer_key: "yJrhKETwuRbzQnxbTIRhGQ",
                            consumer_secret: "BW_9I3vJAF101tVUou6xycrIU9M",
                            token: "jjjTWRC1VEy5bKBvgOO8nntI3Zvr5qFc",
                            token_secret: "BMVINdOoolK113r-_NUEEp6yvuo"
                          })

Neighborhood.delete_all
Size.delete_all
User.delete_all
Category.delete_all
Bike.delete_all
Extra.delete_all

Neighborhood.create!(name: "SoHo")
Neighborhood.create!(name: "Greenwich Village")
Neighborhood.create!(name: "East Village")
Neighborhood.create!(name: "Lower East Side")
Neighborhood.create!(name: "West Village")
Neighborhood.create!(name: "TriBeCa")
Neighborhood.create!(name: "Financial District")
Neighborhood.create!(name: "Union Square")
Neighborhood.create!(name: "Chelsea")
Neighborhood.create!(name: "Gramercy")

Size.create!(size: "XS", frame_size: "15\"-16\"", suggested_height:"5'0\"-5'3\"")
Size.create!(size:"S", frame_size: "16\"-17\"", suggested_height: "5'4\"-5'7\"")
Size.create!(size:"M", frame_size: "18\"-19\"", suggested_height: "5'8\"-5'10\"")
Size.create!(size:"L", frame_size: "20\"-21\"", suggested_height: "5'11\"-6'2\"")
Size.create!(size:"XL", frame_size: "22\"-23\"", suggested_height: "6/3\"+")

Category.create!(name: "Road Bike")
Category.create!(name: "Road Bike (Compact)")
Category.create!(name: "Mountain Bike")
Category.create!(name: "BMX Bike")
Category.create!(name: "Cruiser")
Category.create!(name: "Fixed Gear")

e1 = Extra.create!(name:"Helmet")
e2 = Extra.create!(name:"Lock")
e3 = Extra.create!(name:"Headlight")
e4 = Extra.create!(name:"Taillight")

#######
User.create!(id: 1,
             fname: "Seth",
             lname: "Hamlin",
             email: 'email@example.com',
             password: "password",
             neighborhood: Neighborhood.find_by(name: "SoHo"),
             size: Size.find_by(size: "M"),
             activated: true,
             address: "598 Broadway")

25.times do |num|
  user = User.new(id: num + 2,
                  fname: Faker::Name.first_name,
                  lname: Faker::Name.last_name,
                  email: Faker::Internet.email,
                  password: "password",
                  neighborhood: Neighborhood.all.sample,
                  size: Size.all.sample,
                  activated: true,
                  picture: Faker::Avatar.image)

  addrs = JSON.parse(client.search('#{user.neighborhood.name}, New York, NY').to_json)

  user.address = addrs['businesses'].sample['location']['address'][0]

  user.save!
end

50.times do |num|
  b = Bike.new(id: num + 1,
               name: [Faker::Name.first_name, Faker::Team.creature, Faker::Hacker.noun].sample.capitalize,
               gender: ["Men's", "Women's"].sample,
               size: Size.all.sample,
               num_gears: (1..25).to_a.sample,
               hourly_price: (10..50).to_a.sample,
               category: Category.all.sample,
               owner: User.all.sample)

  num_add_ons = [0,1,2,3,4].sample
  b.add_on_ids = []

  num_add_ons.times do |num|
    b.add_on_ids << num
  end

  b.save!
end
