class PostCommentsController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    @post_comment = current_user.post_comments.new(post_comment_params)
    @post_comment.book_id = @book.id
    if @post_comment.save
      redirect_to book_path(@book.id)
    else
      render 'books/show'
    end
  end

  def destroy
    @book = Book.find(params[:book_id])
    post_comment = @book.post_comments.find(params[:id])
    post_comment.destroy
    redirect_back(fallback_location: root_path)
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)

  end
end
