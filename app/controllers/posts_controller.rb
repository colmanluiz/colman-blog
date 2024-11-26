class PostsController < ApplicationController
  http_basic_authenticate_with name: "colman", password: "safada", except: %i[ index show ]
  before_action :find_posts, only: %i[ show edit update destroy ]
  def index
    @posts = Post.all
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
      params.expect(post: [ :title, :body, :status ])
    end

    def find_posts
      @post = Post.find(params[:id])
    end
end
