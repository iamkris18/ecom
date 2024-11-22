class ActiveStorage::Attachment < ApplicationRecord
    def self.ransackable_attributes(auth_object = nil)
      %w[blob_id created_at id name record_id record_type updated_at]
    end
  end
  