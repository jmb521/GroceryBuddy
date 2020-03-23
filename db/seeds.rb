# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?


Item.create(:name => "Dairy: Milk, Eggs")
Item.create(:name => "Paper Products: Toilet Paper, Paper Towels")
Item.create(:name => "Meat: Chicken, Beef, Pork")
Item.create(:name => "General Food items: Canned Goods, Cereal, Frozen foods, etc")
Item.create(:name => "Baby: Diapers, Wipes, Formula")
Item.create(:name => "Medicine: Cough Medicine, Tylenol, etc.")
Item.create(:name => "Cleaning: Wipes, sprays, sanitizers and soaps")