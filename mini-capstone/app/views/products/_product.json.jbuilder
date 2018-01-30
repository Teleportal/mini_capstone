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
json.images product.images
json.description product.description
json.is_discounted product.discounted?
json.supplier product.supplier
