class Book < ApplicationRecord
  belongs_to :library
  has_many :book_categories, dependent: :destroy
  has_many :categories, through: :book_categories
  has_many :logs, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :title, :author, presence: true

  LOAN_DURATION = 14

  def self.ransackable_attributes(auth_object = nil)
    [ "author", "book_category_id", "category_id", "created_at", "id", "library_id", "published_date", "quantity", "title", "updated_at" ]
  end

  def self.ransackable_associations(auth_object = nil)
    [ "book_categories", "categories", "comments", "library", "logs" ]
  end

  def overdue?
    return false unless borrowed?
    borrowered_at < LOAN_DURATION.days.ago
  end

  def get_email
    return false unless User.find_by(id: borrower_id)

    User.find(borrower_id).email
  end

  def borrowed?
    borrower_id != nil and borrower_id != -1
  end
end
