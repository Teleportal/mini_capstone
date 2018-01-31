module ImageController
  def image_create_action
    client_params = add_image_form

    json_data = post_request("/images", client_params)
    if !json_data["errors"]
      new_image = Image.new(json_data)
      products_show_view(new_image)
    else
      errors = json_data["errors"]
      product_errors_view(errors)
    end
  end
end