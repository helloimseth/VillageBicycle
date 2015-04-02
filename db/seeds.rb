require 'yelp'
require 'faker'

client = Yelp::Client.new({ consumer_key: "yJrhKETwuRbzQnxbTIRhGQ",
                            consumer_secret: "BW_9I3vJAF101tVUou6xycrIU9M",
                            token: "jjjTWRC1VEy5bKBvgOO8nntI3Zvr5qFc",
                            token_secret: "BMVINdOoolK113r-_NUEEp6yvuo"
                          })
Request.delete_all
Neighborhood.delete_all
Size.delete_all
User.delete_all
Category.delete_all
Bike.delete_all
AddOn.delete_all
Extra.delete_all

Neighborhood.create!(name: "SoHo")
Neighborhood.create!(name: "Greenwich Village")
Neighborhood.create!(name: "The East Village")
Neighborhood.create!(name: "The Lower East Side")
Neighborhood.create!(name: "The West Village")
Neighborhood.create!(name: "TriBeCa")
Neighborhood.create!(name: "The Financial District")
Neighborhood.create!(name: "Union Square")
Neighborhood.create!(name: "Chelsea")
Neighborhood.create!(name: "Gramercy")

Size.create!(size: "XS", frame_size: "15\"-16\"", suggested_height:"5'0\"-5'3\"")
Size.create!(size:"S", frame_size: "16\"-17\"", suggested_height: "5'4\"-5'7\"")
Size.create!(size:"M", frame_size: "18\"-19\"", suggested_height: "5'8\"-5'10\"")
Size.create!(size:"L", frame_size: "20\"-21\"", suggested_height: "5'11\"-6'2\"")
Size.create!(size:"XL", frame_size: "22\"-23\"", suggested_height: "6/3\"+")

Category.create!(name: "Road Bike")
Category.create!(name: "Recumbent Bike")
Category.create!(name: "Mountain Bike")
Category.create!(name: "BMX Bike")
Category.create!(name: "Cruiser")
Category.create!(name: "Fixed Gear")

e1 = Extra.create!(name:"Helmet")
e2 = Extra.create!(name:"Lock")
e3 = Extra.create!(name:"Headlight")
e4 = Extra.create!(name:"Taillight")

#######
seth = User.create!(fname: "Seth",
                   lname: "Hamlin",
                   email: 'email@example.com',
                   password: "password",
                   neighborhood: Neighborhood.find_by(name: "Greenwich Village"),
                   size: Size.find_by(size: "M"),
                   activated: true,
                   address: "Washington Square Park")

25.times do
  user = User.new(fname: Faker::Name.first_name,
                  lname: Faker::Name.last_name,
                  email: Faker::Internet.email,
                  password: "password",
                  bio: Faker::Hacker.say_something_smart,
                  neighborhood: Neighborhood.all.sample,
                  size: Size.all.sample,
                  activated: true,
                  picture: Faker::Avatar.image)

  addrs = JSON.parse(client.search('#{user.neighborhood.name}, New York, NY').to_json)

  user.address = addrs['businesses'].sample['location']['address'][0]

  user.save!
end

50.times do
  b = Bike.new(name: [Faker::Name.first_name, Faker::Team.creature, Faker::Hacker.noun].sample.capitalize,
               gender: ["Men's", "Women's"].sample,
               notes: Faker::Hacker.say_something_smart,
               size: Size.all.sample,
               num_gears: (1..25).to_a.sample,
               hourly_price: (10..50).to_a.sample,
               category: Category.all.sample,
               owner: User.all.sample)

  num_extras = [1,2,3,4,5].sample
  extras = []

  num_extras.times do
    extra = Extra.all.sample
    extras << extra unless extras.include?(extra)
  end

  b.extras = extras

  b.save!
end

3.times do
  user = User.all.sample
  while user == seth
    user = User.all.sample
  end

  user.requests_made.create!(bike: seth.bikes.sample,
                             start: DateTime.now,
                             end: DateTime.tomorrow)
end

def new_request
  user = User.all.sample
  bike = Bike.all.sample
  start_date = (1..500).to_a.sample.days.from_now
  end_date = start_date + (1..10.to_a.sample).days

  while user.bikes.include?(bike)
    bike = Bike.all.sample
  end

  user.requests_made.new(bike: bike,
                         start: start_date,
                         end: end_date,
                         approved: [nil, true, false].sample)
end

75.times do
  request = new_request

  until request.save
    request = new_request
  end
end
