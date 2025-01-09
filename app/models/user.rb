class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :logs, dependent: :destroy
  has_many :borrowed_books, class_name: "Book", foreign_key: "borrower_id"

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "email", "encrypted_password", "id", "id_value", "remember_created_at", "reset_password_sent_at", "reset_password_token", "role", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["logs", "borrowed_books"]
  end

  def borrow_book(book)
    book.update(borrower_id: self.id, borrowed_at: Time.current)
    Log.create(user: self, action: "Borrowed Book", details: "#{self.email} borrowed book #{book.title}")
  end

  def is_admin?
    self.role == "admin"
  end
end
