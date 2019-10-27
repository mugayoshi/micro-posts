class SessionsController < ApplicationController
  def new
  end

  def create
    email = params[:session][:email].downcase
    password = params[:session][:password]
    if login(email, password)
      flash[:success] = 'login success!'
      redirect_to @user
    else
      flash.now[:danger] = 'login failed!'
      render 'new'
    end
  end

  def destroy
  end
  
  private

  def login(email, password)
    @user = User.find_by(email: email)
    if @user && @user.authenticate(password)
      # login sucess
      session[:user_id] = @user.id
      return true
    else
      # login failed
      return false
    end
  end
end
