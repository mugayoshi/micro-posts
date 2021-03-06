class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show, :followings, :followers, :favourites]
  
  def index
    @users = User.all.page(params[:page])
    # .page() is for pagination
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.order('created_at DESC').page(params[:page])
    counts(@user)
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
  
  def followings
    @user = User.find(params[:id])
    @followings = @user.followings.page(params[:page])
    counts(@user)
  end
  
  def followers
    @user = User.find(params[:id])
    @followers = @user.followers.page(params[:page])
    counts(@user)
  end
  
  def favourites
    @user = User.find(params[:id])
    @favourites = @user.favourites.page(params[:page])
    counts(@user)
  end
    
  
  
end

private

def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
end