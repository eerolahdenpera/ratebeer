class SessionsController < ApplicationController
  def new
    #renderöi kirjautumissivun
  end

  def create
    user = User.find_by username: params[:username]
   if user && user.blocked?
      redirect_to :back, notice: "your account is frozen, please contact admin"
    else if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to user_path(user), notice: "Welcome back!"
    else
      redirect_to :back, notice: "username and password do not match"
     end
    end
  end

  def destroy
    #nollataan sessio
    session[:user_id] = nil
    #uudelleenohjataan sovellus pääsivulle
    redirect_to :root
  end
end