class HomeController < ApplicationController
  def index
    @categories = Category.all
    if params[:category].present?
      @books = Book.joins(:categories).where(categories: { id: params[:category] })
    else
      @books = Book.all
    end
  end
end
