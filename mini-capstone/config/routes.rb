Rails.application.routes.draw do
  get "/all_products" => 'products#all_products_method'
  get "/product_1" => 'products#product_1_method'
  get "/product_2" => 'products#product_2_method'
  get "/product_3" => 'products#product_3_method'
end
