class UsersController < ApplicationController
  
  def authenticate

    un = params.fetch("input_username")
    pw = params.fetch("input_password")

    user = User.where({ :username => un }).at(0)


    if user == nil
      redirect_to("/user_sign_in", { :alert => "No one by that name around here"})
    else
      if user.authenticate(pw)
        session.store(:user_id, user.id)
      redirect_to("/", { :notice => "Welcome back," + user.username})
      else
        redirect_to("/user_sign_in", { :alert => "Nice try, hennie"})

      end

    end
    #render({ :plain => "hi"})

    #get the username from params
    #get the password from params

    #look up the record from the db mtching username
    #if there's no record, redirect back to sign in form

    #if there is a record, check to see if password matches
    #if not, redirect back to sign in form

    #if so, set the cookie
    #redirect to homepage


  end


  def toast_cookies
    reset_session

    redirect_to("/", {:notice => "Bye Bitch"})
  end
  
  def new_registration_form

    render({ :template => "users/signup_form.html.erb"})

  end
  
  def new_session_form

    render({ :template => "users/signin_form.html.erb"})

  end
  
  def index
    @users = User.all.order({ :username => :asc })

    render({ :template => "users/index.html" })
  end

  def show
    the_username = params.fetch("the_username")
    @user = User.where({ :username => the_username }).at(0)

    render({ :template => "users/show.html.erb" })
  end

  def create
    user = User.new

    user.username = params.fetch("input_username")

    user.password = params.fetch("input_password")

    user.password_confirmation = params.fetch("input_password_confirmation")

   save_status = user.save
  

   if save_status == true
    session.store(:user_id, user.id)

    redirect_to("/users/#{user.username}", { :notice => "Welcome, " + user.username + "!"})
   else
    redirect_to("/user_sign_up", { :alert => user.errors.full_messages})
   end
  end

  def update
    the_id = params.fetch("the_user_id")
    user = User.where({ :id => the_id }).at(0)


    user.username = params.fetch("input_username")

    user.save
    
    redirect_to("/users/#{user.username}")
  end

  def destroy
    username = params.fetch("the_username")
    user = User.where({ :username => username }).at(0)

    user.destroy

    redirect_to("/users")
  end

  def sign_up

    redirect_to("/users")
  end
end
