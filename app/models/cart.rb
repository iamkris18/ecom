class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items, dependent: :destroy

  def self.ransackable_associations(auth_object = nil)
    ["cart_items", "user"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "id_value", "updated_at", "user_id"]
  end
end
