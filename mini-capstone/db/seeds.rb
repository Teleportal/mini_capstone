# Image.create!([
#   {url: "https://media.boingboing.net/wp-content/uploads/2012/08/dundraggg.jpg", product_id: 1},
#   {url: "https://images-na.ssl-images-amazon.com/images/I/61j03TVRvZL._UX385_.jpg", product_id: 2},
#   {url: "http://www.shakespearesglobe.com/shop/images/product/view/1206.jpg", product_id: 3},
#   {url: "http://cdn.broadwaymerchandiseshop.com/media/catalog/product/cache/11/image/9df78eab33525d08d6e5fb8d27136e95/h/m/hmi144_1.jpg", product_id: 4},
#   {url: "https://cdn.shopify.com/s/files/1/1829/4817/products/wg-flanking_500x.jpg?v=1492888492", product_id: 5},
#   {url: "https://img00.deviantart.net/b1fb/i/2012/276/c/f/gencon_indy_front_2012_by_irondmnecessaryevil-d5gqbnm.png", product_id: 7},
#   {url: "https://cdn.shopify.com/s/files/1/0537/1501/products/DD_Dunkin_Tee2_1024x1024.jpg?v=1497966487", product_id: 1}
# ])
# Order.create!([
#   {user_id: 3, product_id: 1, quantity: 2, subtotal: "36.0", tax: "3.24", total: "39.24"},
#   {user_id: 3, product_id: 1, quantity: 2, subtotal: "36.0", tax: "3.24", total: "39.24"},
#   {user_id: 3, product_id: 2, quantity: 2, subtotal: "32.0", tax: "2.88", total: "34.88"},
#   {user_id: 3, product_id: 2, quantity: 2, subtotal: "32.0", tax: "2.88", total: "34.88"},
#   {user_id: 3, product_id: 2, quantity: 2, subtotal: "32.0", tax: "2.88", total: "34.88"},
#   {user_id: 4, product_id: 5, quantity: 2, subtotal: "30.0", tax: "2.7", total: "32.7"},
#   {user_id: 4, product_id: 7, quantity: 10, subtotal: "140.0", tax: "12.6", total: "152.6"}
# ])
# Product.create!([
#   {name: "Dungins' N' Dragons Shirt", price: "18.0", description: "A shirt that combines the fun of D&D and the symbology of Dunkin Donuts", in_stock: true, supplier_id: 1},
#   {name: "Steven Universe Star Shirt", price: "16.0", description: "Steven Universe's very own T-shirt!", in_stock: true, supplier_id: 3},
#   {name: "Midsummer's Night Dream Puck Quote Shirt", price: "20.0", description: "Ever wanted to let those foolish mortals know how foolish they are? This shirt is for you.", in_stock: true, supplier_id: 1},
#   {name: "Hamilton Shirt", price: "22.0", description: "A shirt for those who are young, scrappy, and/or hungry", in_stock: true, supplier_id: 2},
#   {name: "I'm with Flanking Bonus Shirt", price: "15.0", description: "For when your buddy doesn't just have your back, but the back of your enemies.", in_stock: true, supplier_id: 2},
#   {name: "Iron GM 2012", price: "14.0", description: "What is best in life? Roleplaying games!", in_stock: true, supplier_id: 1},
#   {name: "Superfriends Shirt", price: "12.0", description: "Superfriends are for forever.", in_stock: true, supplier_id: 1},
#   {name: "Plain White Tee", price: "10.0", description: "It's white.", in_stock: true, supplier_id: 3}
# ])
# Supplier.create!([
#   {name: "Odd World", email: "supplier@oddworld.com", phone_number: "555-555-5555"},
#   {name: "T-Spring", email: "supplier@t-spring.com", phone_number: "555-555-5554"},
#   {name: "ForFansByFans", email: "forfansbyfans@welovefine.com", phone_number: "555-555-5557"}
# ])
# User.create!([
#   {name: "Josh", email: "joshthegreenberg@gmail.com", password_digest: "$2a$10$4P1r3KHT5HUJneaVQoGcce4aMmgGlLkKQ/oH3NnVrHvo68/1UK0B2", admin: false},
#   {name: "Cassie", email: "triannakumira@gmail.com", password_digest: "$2a$10$AG5l.wnAdyQ3S0oyvsUimeD2Apvig4TOjlcdxMJcodYKCpM/XX.IK", admin: false},
#   {name: "charlie brown", email: "charlie@brown.com", password_digest: "$2a$10$QghDhY7CrIDRriQS8iVN2urPZX9D5RU13jPVnsU8bm/UUkYmQLTMK", admin: false},
#   {name: "abc", email: "a@b.c", password_digest: "$2a$10$jPEZgxUgJ.GfovELRSsPk.qX39tdOMz6W7B1ZKITHq/uDtKUKaxQ2", admin: true}
# ])

Category.create!([
                  {name: "Roleplaying Games"},
                  {name: "Nerdy"},
                  {name: "Theater"},
                  {name: "Pop Culture"}
                ])

ProductCategory.create!([
                  {category_id: 1, product_id: 1},
                  {category_id: 1, product_id: 5},
                  {category_id: 1, product_id: 7},
                  {category_id: 2, product_id: 1},
                  {category_id: 2, product_id: 2},
                  {category_id: 2, product_id: 3},
                  {category_id: 2, product_id: 4},
                  {category_id: 2, product_id: 5},
                  {category_id: 2, product_id: 7},
                  {category_id: 2, product_id: 8},
                  {category_id: 3, product_id: 3},
                  {category_id: 3, product_id: 4},
                  {category_id: 4, product_id: 1},
                  {category_id: 4, product_id: 2},
                  {category_id: 4, product_id: 4},
                  {category_id: 4, product_id: 8},
                  {category_id: 4, product_id: 9}
                ])

