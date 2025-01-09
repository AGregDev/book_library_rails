class Log < ApplicationRecord
  belongs_to :user

  def self.ransackable_attributes(auth_object = nil)
    ["action", "created_at", "details", "id", "updated_at", "user_id"]
  end
end
