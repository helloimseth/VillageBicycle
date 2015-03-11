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

u1 = User.create!(fname:"Seth", lname: "Hamlin", email: "email@example.com",
                  password: "password", neighborhood_id: 1, size_id: 3,
                  activated: true)
u2 = User.create!(fname:"Bill", lname: "DeBlasio", email: "mayor@example.com",
                  password: "password", neighborhood_id: 7, size_id: 5,
                  activated: true)
u3 = User.create!(fname:"Beyonce", lname: "Knowles", email: "yonce@example.com",
                  password: "password", neighborhood_id: 6, size_id: 1,
                  activated: true)

Category.create!(name: "Road Bike")
Category.create!(name: "Road Bike (Compact)")
Category.create!(name: "Mountain Bike")
Category.create!(name: "BMX Bike")
Category.create!(name: "Cruiser")
Category.create!(name: "Fixed Gear")


u1.bikes.create!(name: "Lucy", gender: "Men's", size_id: 2, num_gears: 6,
                 hourly_price: 27, category_id: 1)
u1.bikes.create!(name: "Cougar", gender: "Men's", size_id: 3, num_gears: 1,
                 hourly_price: 10, category_id: 4)

u2.bikes.create!(name: "Big Apple", gender: "Men's", size_id: 5, num_gears: 12,
                 hourly_price: 20, category_id: 2)
u2.bikes.create!(name: "The Manimal", gender: "Men's", size_id: 5, num_gears: 16,
                 hourly_price: 50, category_id: 3)


u3.bikes.create!(name: "Partition", gender: "Women's", size_id: 1, num_gears: 3,
                 hourly_price: 15, category_id: 5)
u3.bikes.create!(name: "Independent Woman", gender: "Women's", size_id: 1, num_gears: 12,
                 hourly_price: 44, category_id: 1)
