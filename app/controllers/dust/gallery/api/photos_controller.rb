module Dust
  module Gallery
    module Api
      class PhotosController < ApplicationController

        respond_to :json

        def show
          respond_with Dust::Gallery::Photo.find(params[:id])
        end

        def create
          file = AppSpecificStringIO.new(params[:qqfile], request.raw_post)
          respond_with Dust::Gallery::Photo.create :filename => file, :album_id => params[:album_id]
        end

        def update
          respond_with Dust::Gallery::Photo.update params[:dust_gallery_photo]
        end

        def destroy
          respond_with Dust::Gallery::Photo.destroy params[:id]
        end

      end
    end
  end
end
