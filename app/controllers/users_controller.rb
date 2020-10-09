class UsersController < ApplicationController
before_action :set_user, only: [:show, :edit, :update, :favorites]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to new_session_path(@user.id)
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if current_user == @user
      if @user.update(user_params)
        flash[:success] = 'Edited Your Information'
        redirect_to user_path(@user.id)
      else
        flash.now[:danger] = 'Failed Edited Your Information。'
        render :edit
      end
      else
        redirect_to "users/new"
    end
  end

  def favorites
    @favorites = Favorite.where(user_id: @user.id)
  end


  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation,
                                 :image)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
