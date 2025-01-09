class Book < ApplicationRecord
  belongs_to :library
  has_many :book_categories, dependent: :destroy
  has_many :categories, through: :book_categories
  has_many :logs, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :title, :author, presence: true

  def self.ransackable_attributes(auth_object = nil)
    ["author", "book_category_id", "category_id", "created_at", "id", "library_id", "published_date", "quantity", "title", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["book_categories", "categories", "comments", "library", "logs"]
  end
end
