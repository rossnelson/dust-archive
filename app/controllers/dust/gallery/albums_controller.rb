module Dust
  module Gallery
    class AlbumsController < ApplicationController

      filter_access_to :all

      layout 'cms'

      def index
        @albums = Dust::Gallery::Album.all
      end

      def new
        @album = Dust::Gallery::Album.new
      end

      def edit
        @album = Dust::Gallery::Album.find(params[:id])
      end

      def create
        @album = Dust::Gallery::Album.new(params[:dust_gallery_album])

        if @album.save
          redirect_to edit_dust_gallery_album_path(@album), notice: 'Album was successfully created.'
        else
          render action: "new"
        end
      end

      def update
        @album = Dust::Gallery::Album.find(params[:id])

        if @album.update_attributes(params[:dust_gallery_album])
          redirect_to dust_gallery_albums_path, notice: 'Album was successfully updated.'
        else
          render action: "edit"
        end
      end

      def destroy
        @album = Dust::Gallery::Album.find(params[:id])
        @album.destroy

        redirect_to dust_gallery_albums_url
      end
    end
  end
end
