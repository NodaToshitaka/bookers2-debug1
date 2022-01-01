class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:update]

  def show
    @user = User.find(params[:id])
    @books = @user.books.order(created_at: :DESC)
    @book = Book.new
    @following_users = @user.following_user
    @follower_users = @user.follower_user
  end

  def index
    @users = User.all.order(created_at: :DESC)
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
    redirect_to user_path(current_user) unless current_user == @user
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      render :edit
    end
  end

  def follows
    @user = User.find(params[:id])
    @users = @user.following_user.all
  end

  def followers
    @user = User.find(params[:id])
    @users = @user.follower_user.all
  end

  def search
    @user = User.find(params[:id])
    @books =@user.books
    @book = Book.new
    if params[:created_at] == ""
      @search_book = "日時を選択してください"
    else
      created_at = params[:created_at]
      @search_book = @books.where(['created_at LIKE ?', "#{created_at}%"]).count
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end