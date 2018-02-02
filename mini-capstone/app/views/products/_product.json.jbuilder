json.id product.id
json.name product.name
json.price product.price
json.tax product.tax
json.total product.total
json.formatted do
                json.price number_to_currency(product.price)
                json.tax number_to_currency(product.tax)
                json.total number_to_currency(product.total)
end
json.images product.images.map { |image| image[:url] }
json.description product.description
json.is_discounted product.discounted?
json.supplier do
  json.name product.supplier[:name]
  json.email product.supplier[:email]
  json.phone product.supplier[:phone_number]
end
json.categories product.categories.map { |category| category[:name] }