# frozen_string_literal: true

# Module to add table prefix to active storage model classes
module ActiveStorageAttachmentExt
  extend ActiveSupport::Concern

  included do
    self.table_name = 'core.active_storage_attachments'
  end
end

# Module to add table prefix to active storage model classes
module ActiveStorageBlobExt
  extend ActiveSupport::Concern

  included do
    self.table_name = 'core.active_storage_blobs'
  end
end

# Module to add table prefix to active storage model classes
module ActiveStorageVariantRecordExt
  extend ActiveSupport::Concern

  included do
    self.table_name = 'core.active_storage_variant_records'
  end
end

Rails.configuration.to_prepare do
  ActiveStorage::Attachment.include ActiveStorageAttachmentExt
  ActiveStorage::Blob.include ActiveStorageBlobExt
  ActiveStorage::VariantRecord.include ActiveStorageVariantRecordExt
end
