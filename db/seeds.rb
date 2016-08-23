# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Location.create(
  name: "Toronto Convention Centre",
  city: "Toronto",
  description: "Toronto's biggest convention location.",
  image: "http://www.hlta.ca/wp-content/uploads/2015/05/Metro-Toronto-Convention-Centre-11.jpg",
)

Location.create(
  name: "Canada Olympic Park",
  city: "Calgary",
  description: "The home of high performance athletic training.",
  image: "http://img4.onthesnow.com/image/la/82/8277.jpg",
)
