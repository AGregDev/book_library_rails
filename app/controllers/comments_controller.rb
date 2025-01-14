class CommentsController < ApplicationController
  before_action :authenticate_user!

  def destroy
    puts params
    @comment = Comment.find(params[:id])
    @book = Book.find(@comment.book_id)

    if @comment.user == current_user || current_user.is_admin?
      @comment.destroy
      flash[:notice] = "Comment deleted successfully."
    else
      flash[:alert] = "You are not authorized to delete this comment."
    end

    redirect_to borrowed_book_path
  end
end
