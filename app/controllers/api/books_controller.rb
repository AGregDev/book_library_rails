module Api
  class BooksController < ApplicationController
    before_action :set_book, only: [ :show, :update, :destroy ]

    def index
      @books = Book.all
      render json: @books
    end

    def show
      render json: @book
    end

    def create
      @book = Book.new(book_params)
      authorize @book

      if @book.save
        render json: @book, status: :created
      else
        render json: @book.errors, status: :unprocessable_entity
      end
    end

    def update
      authorize @book

      if @book.update(book_params)
        render json: @book
      else
        render json: @book.errors, status: :unprocessable_entity
      end
    end

    def destroy
      authorize @book

      @book.destroy
      head :no_content
    end

    private

    def set_book
      @book = Book.find(params[:id])
    end

    def book_params
      params.require(:book).permit(:title, :author, :library_id)
    end
  end
end
