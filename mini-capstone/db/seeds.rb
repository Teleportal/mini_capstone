# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

shirt = Product.new(name: "Dungins' N' Dragons Shirt",
                    price: 18,
                    image_url: "https://media.boingboing.net/wp-content/uploads/2012/08/dundraggg.jpg",
                    description: "A shirt that combines the fun of D&D and the symbology of Dunkin Donuts"
                    )

shirt.save

shirt = Product.new(name: "Steven Universe Star Shirt",
                    price: 16,
                    image_url: "https://images-na.ssl-images-amazon.com/images/I/61j03TVRvZL._UX385_.jpg",
                    description: "Steven Universe's very own T-shirt!"
                    )

shirt.save

shirt = Product.new(name: "Midsummer's Night Dream Puck Quote Shirt",
                    price: 20,
                    image_url: "http://www.shakespearesglobe.com/shop/images/product/view/1206.jpg",
                    description: "Ever wanted to let those foolish mortals know how foolish they are? This shirt is for you."
                    )

shirt.save