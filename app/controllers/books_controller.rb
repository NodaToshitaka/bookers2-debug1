class BooksController < ApplicationController

  def show
    @book = Book.find(params[:id])
    @post_comment = PostComment.new
  end

  def index
    @book = Book.new
    @books = Book.all.order(created_at: :DESC)
  end

  def tag_index
    @book = Book.new
    tag = Tag.find(params[:id])
    @books = tag.books.order(created_at: :DESC)
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    tag_list = params[:book][:tag_name].split(",")
    if @book.save
      @book.tags_save(tag_list)
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
    redirect_to user_path(current_user) unless current_user == @book.user
  end



  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body, :rate)
  end

end
