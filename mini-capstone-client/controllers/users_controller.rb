module UserController

  def user_create_action
    client_params = user_new_form

    json_data = post_request('/users', client_params)

    if !json_data["errors"]
      new_user = User.new(json_data)
      user_show_view(new_user)
    else
      errors = json_data["errors"]
      product_errors_view(errors)
    end
    
  end

end