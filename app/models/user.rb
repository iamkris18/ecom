class User < ApplicationRecord
    has_one :cart, dependent: :destroy
    has_one_attached :profile_picture

    def self.ransackable_associations(auth_object = nil)
    ["cart", "profile_picture_attachment", "profile_picture_blob"]
    end

    def self.ransackable_attributes(auth_object = nil)
        ["created_at", "email", "id", "id_value", "password", "updated_at"]
    end
end
