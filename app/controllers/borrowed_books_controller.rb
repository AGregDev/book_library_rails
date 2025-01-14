class BorrowedBooksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_book, only: [ :show, :return, :comment ]

  def index
    @categories = Category.all
    @borrowed_books = current_user.borrowed_books
  end

  def show
    @remaining_time = @book.borrowered_at + 2.weeks - Time.current
  end

  def return
    if @book.borrower_id == current_user.id
      @book.update(borrower_id: nil, borrowered_at: nil)
      flash[:notice] = "You have successfully returned the book."
    else
      flash[:alert] = "You cannot return this book."
    end
    redirect_to borrowed_books_path
  end

  def comment
    if @book.borrower_id == current_user.id
      @book.comments.create(content: params[:comment], user: current_user)
      flash[:notice] = "Your comment has been added."
    else
      flash[:alert] = "You cannot comment on this book."
    end
    redirect_to borrowed_books_path(@book)
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end
end
