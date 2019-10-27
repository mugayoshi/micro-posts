class UsersController < ApplicationController
  def index
    @users = User.all.page(params[:page])
    # .page() is for pagination
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = 'success, user is registered!'
      redirect_to @user
    else
      flash.now[:danger] = 'user registration is failed!'
      render :new
    end

    
  end
end

private

def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
end