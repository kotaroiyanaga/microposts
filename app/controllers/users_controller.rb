class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :show, :following, :followers]
  
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.order(created_at: :desc)
    @following = @user.following_users
    @followers = @user.follower_users
  end
  
  def new
    @user = User.new
  end
  
  def edit
    @user = User.find(params[:id])
    if (@current_user.id != @user.id)
      redirect_to root_path
    end
     # http://hogehoge/users/1/edit
     #@user = User.find(params[:id])
     # form_for(@user)
     
  end
  
  def update
    @user = User.find(params[:id])
    if ( @current_user.id != @user.id)
       redirect_to root_path
       return
    end
    if @user.update(user_profile)
      redirect_to user_path , notice: 'ユーザー情報を更新しました'
    else
      render 'edit'
      flash[:alert] = "エラーが発生しました"
    end
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @following_users = @user.following_users
    render 'show_follow'
  end
  
  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @followers_users = @user.follower_users
    render 'show_follow'
  end

  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end
  
  def user_profile
    params.require(:user).permit(:name, :email, :password,
                    :password_confirmation, :region)
  end
end

 
