
ActiveSupport.on_load(:active_storage_attachment) do
    ActiveStorage::Attachment.class_eval do
      def self.ransackable_attributes(auth_object = nil)
        %w[blob_id created_at id name record_id record_type updated_at]
      end
    end
  end
  