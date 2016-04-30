class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  
  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end
  
  def edit
    if (current_user != params[:id])
       redirect_to "home"
    end
     # http://hogehoge/users/1/edit
    @user = User.find(params[:id])
     # form_for(@user) 
  end
  
  def update
    if (current_user != params[:id])
       redirect_to "home"
    end
    if @user.update(user_params)
      redirect_to user_path , notice: 'ユーザー情報を更新しました'
    else
      render 'edit'
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

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end
end
