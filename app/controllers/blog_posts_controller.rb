class BlogPostsController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]
    before_action :set_blog_post, except: [:index, :new, :create, :edit]

    protect_from_forgery with: :null_session

    def index
        @blog_posts = user_signed_in? ? BlogPost.sorted : BlogPost.published.sorted
    end

    def show
    end

    def new
        @blog_post = BlogPost.new

    end

    require 'aws-sdk-s3'


    def create
        @blog_post = BlogPost.new(blog_post_params)
        @blog_post.published_at = params[:blog_post][:draft] == "0" ? Time.current : nil



      
        if @blog_post.save
          redirect_to @blog_post
        else
          render :new, status: :unprocessable_entity
        end
      end
      

    def edit
        @blog_post = BlogPost.find(params[:id])
    rescue ActiveRecord::RecordNotFound
        redirect_to root_path
    end

    def update
        if @blog_post.update(blog_post_params)
            redirect_to @blog_post
        else
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        @blog_post.destroy
        redirect_to root_path
    end

    private

    def blog_post_params
        params.require(:blog_post).permit(:title, :content, :published_at)
    end

    def set_blog_post
        @blog_post = user_signed_in? ? BlogPost.find(params[:id]) : BlogPost.published.find(params[:id])
    rescue ActiveRecord::RecordNotFound
        redirect_to root_path
    end
end