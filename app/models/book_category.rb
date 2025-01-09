class BookCategory < ApplicationRecord
  belongs_to :book
  belongs_to :category

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "name", "updated_at"]
  end
end
