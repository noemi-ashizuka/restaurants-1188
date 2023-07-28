puts 'Removing the restaurants...'
User.destroy_all
Restaurant.destroy_all

chefs = %W[Bowman Pablo Kevin Saki Trevor Joe Ben Juri Valerie Curtis Buruburu Tenny Giulia Kiyoe Ryo Kyle Chris Aaron Simone Alexia Jonny Favio Benjamin Kathryn Zhan Abby]
categories = %W[burgers ramen sushi desserts healthy kebabs pizza tacos sandwiches dumplings soup curry rice pasta steak vegan bakery juice salads seafood brunch wings cafe bbq deli pies buffet]

puts "Creating users..."
users = [
  {
    username: 'noemi-ashizuka',
    email: 'noemi@me.com',
  },
  {
    username: 'yannklein',
    email: 'yann@me.com'
  }
]
users.each do |user_hash|
  user = User.new(user_hash)
  user.password = 123123
  user.save!
end

puts "Creating #{chefs.count} Restaurants..."
chefs.shuffle.each do |name|
  Restaurant.create!(
    name: "#{name}'s #{Faker::Restaurant.name}",
    description: Faker::Restaurant.description,
    address: Faker::Address.street_address,
    rating: rand(1..5),
    category: categories.delete_at(rand(0...categories.length)),
    chef_name: name,
    user: User.all.sample
  )
end
puts "...created #{Restaurant.count} restaurants"

puts "Creating reviews..."
Restaurant.all.each do |restaurant|
  rand(0..10).times do
    Review.create!(
      content: Faker::Restaurant.review,
      restaurant: restaurant
    )
  end
end
puts "...created #{Review.count} reviews"
