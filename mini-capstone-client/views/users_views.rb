module UsersViews

  def user_show_view(user)
    puts
    puts "User name: #{user.name}"
    puts "User email: #{user.email}"
    puts "User encrypted password: #{user.password_digest}"
    puts
  end

  def user_new_form
    client_params = {}
    
    print "What is the user's name: "
    client_params[:name] = gets.chomp

    print "What is the user's email: "
    client_params[:email] = gets.chomp

    print "Enter the user's password: "
    client_params[:password] = gets.chomp

    print "Confirm the user's password: "
    client_params[:password_confirmation] = gets.chomp

    client_params
  end



end