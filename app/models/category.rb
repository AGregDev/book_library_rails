class Category < ApplicationRecord
  has_many :book_categories, dependent: :destroy
  has_many :books, through: :book_categories

  def self.ransackable_attributes(auth_object = nil)
    [ "created_at", "id", "id_value", "name", "updated_at" ]
  end

  def self.ransackable_associations(auth_object = nil)
    [ "book_categories", "books" ]
  end
end
