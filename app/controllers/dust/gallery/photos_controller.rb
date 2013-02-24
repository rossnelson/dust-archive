module Dust
  module Gallery
    class PhotosController < ApplicationController

      filter_access_to :all

      layout 'cms'

      def show
        @photo = Dust::Gallery::Photo.find params[:id]
      end

      def edit
        @photo = Dust::Gallery::Photo.find params[:id]
      end

      def create
        file = AppSpecificStringIO.new(params[:qqfile], request.raw_post)
        @photo = Dust::Gallery::Photo.new :filename => file, :album_id => params[:album_id]

        if @photo.save
          redirect_to @photo, notice: 'Photo was successfully created.'
        else
          render :json => {success: false}
        end
      end

      def update
        @photo = Photo.find(params[:id])

        if @photo.update_attributes(params[:dust_gallery_photo])
          redirect_to edit_dust_gallery_album_path(@photo.album), notice: 'Photo was successfully updated.'
        else
          render action: "edit"
        end
      end

      def destroy
        @photo = Photo.find(params[:id])
        @photo.destroy

        redirect_to edit_dust_gallery_album_path(@photo.album)
      end

      def sort
        @menu_sort = Dust::MenuSort.new(params[:list], params[:class_name])

        flash[:notice] = "Successfully Sorted Album."
      end

    end
  end
end
