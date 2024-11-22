class UserActivity < ApplicationRecord
  belongs_to :user

  def self.ransackable_associations(auth_object = nil)
    ["user"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["action", "created_at", "id", "id_value", "metadata", "performed_at", "updated_at", "user_id"]
  end

end
