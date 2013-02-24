module Dust
  module Gallery
    class Photo < ActiveRecord::Base
      attr_accessible :description, :lft, :parent_id, :rgt, :title, :album_id, :filename
      acts_as_nested_set

      mount_uploader :filename, GalleryPhotoUploader

      belongs_to :album

      validates_presence_of :album_id

      def url
        filename.url
      end

      def success
        true
      end

    end
  end
end
