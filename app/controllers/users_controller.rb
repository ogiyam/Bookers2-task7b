class UsersController < ApplicationController

  before_action :authenticate_user!,except: [:top]
  before_action :correct_user,   only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @new_book = Book.new
    @books = @user.books
  end

  def index
    @user = current_user
    @users = User.all
    @new_book = Book.new
    @books = Book.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
       flash[:notice]="You have updated user successfully."
       redirect_to user_path(current_user)
    else
      flash.now[:error] = @user.errors.full_messages
      render "edit"
    end
  end

private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def correct_user
   @user = User.find(params[:id])
   if @user.id != current_user.id
     redirect_to user_path(current_user)
   end
  end
end

