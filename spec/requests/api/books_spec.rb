require 'rails_helper'

RSpec.describe "Api::Books", type: :request do
  include Devise::Test::IntegrationHelpers

  let(:admin_user) { create(:user, :admin) }
  let(:regular_user) { create(:user, :user) }

  describe "GET /api/books" do
    it "returns a list of books" do
      library1 = create(:library, name: "Library 1")
      library2 = create(:library, name: "Library 2")

      create(:book, title: "Book 1", author: "Author 1", library: library1)
      create(:book, title: "Book 2", author: "Author 2", library: library2)

      sign_in admin_user

      get api_books_path
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(Book.count)
    end
  end

  describe "POST /api/books" do
    let(:book_params) { { title: "New Book", author: "New Author", library_id: create(:library).id } }

    context "when admin user" do
      it "creates a new book" do
        sign_in admin_user

        post api_books_path, params: { book: book_params }
        expect(response).to have_http_status(:created)
        expect(Book.last.title).to eq("New Book")
      end
    end

    context "when regular user" do
      it "is forbidden" do
        sign_in regular_user

        post api_books_path, params: { book: book_params }
        expect(response).to have_http_status(:forbidden)
      end
    end
  end

  describe "DELETE /api/books/:id" do
    let!(:book) { create(:book, title: "Delete Book", author: "Delete Author", published_date: "2023-04-01") }

    context "when admin user" do
      it "deletes the book" do
        sign_in admin_user

        delete api_book_path(book)
        expect(response).to have_http_status(:no_content)
        expect(Book.exists?(book.id)).to be_falsey
      end
    end

    context "when regular user" do
      it "is forbidden" do
        sign_in regular_user

        delete api_book_path(book)
        expect(response).to have_http_status(:forbidden)
      end
    end
  end
end
