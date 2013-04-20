module Dust
  class PostsController < ApplicationController

    filter_access_to :all

    layout 'cms'

    def index
      @posts = Post.all
    end

    def new
      @post = Post.new_with_menu_item
    end

    def edit
      @post = Post.find(params[:id])
    end

    def create
      @post = Post.new_with_menu_item(params[:dust_post])

      if @post.save
        redirect_to front_end_post_path(@post.slug), notice: 'Post was successfully created.'
      else
        render action: "new"
      end
    end

    def update
      @post = Post.find(params[:id])

      if @post.update_attributes(params[:dust_post])
        redirect_to front_end_post_path(@post.slug), notice: 'Post was successfully updated.'
      else
        render action: "edit"
      end
    end

    def destroy
      @post = Post.find(params[:id])
      @post.destroy

      redirect_to posts_url
    end
  end
end
