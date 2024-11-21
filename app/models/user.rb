class User < ApplicationRecord
    has_one :cart, dependent: :destroy
    has_one_attached :profile_picture
end
