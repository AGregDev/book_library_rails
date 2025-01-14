class Library < ApplicationRecord
  has_many :books, dependent: :destroy

  def self.ransackable_attributes(auth_object = nil)
    [ "created_at", "id", "location", "name", "updated_at" ]
  end

  def self.ransackable_associations(auth_object = nil)
    [ "books" ]
  end
end
