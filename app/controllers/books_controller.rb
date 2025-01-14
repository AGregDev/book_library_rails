class BooksController < ApplicationController
  before_action :authenticate_user!

  def borrow
    @book = Book.find(params[:id])

    unless @book.borrowed?
      current_user.borrow_book(@book)
      flash[:notice] = "You have successfully borrowed the book."
    else
      flash[:alert] = "This book is already borrowed."
    end

    redirect_to root_path
  end
end
