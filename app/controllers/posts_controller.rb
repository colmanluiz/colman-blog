class PostsController < ApplicationController
  before_action :authenticate_user!, except: %i[ index show ]
  before_action :find_posts, only: %i[ show edit update destroy ]
  def index
    @posts = user_signed_in? ? Post.sorted : Post.published.sorted
  end

  def show
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)

    return redirect_to @post if @post.save

    render :new, status: :unprocessable_entity
  end

  def edit
  end

  def update
    return redirect_to @post if @post.update(post_params)

    render :edit, status: :unprocessable_entity
  end

  def destroy
    @post.destroy

    redirect_to root_path, status: :see_other
  end

  private
    def post_params
      params.expect(post: [ :title, :body, :status, :published_at ])
    end

    def find_posts
      @post = user_signed_in? ? Post.find(params[:id]) : Post.published.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to root_path
    end
end
