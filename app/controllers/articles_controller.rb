class ArticlesController < ApplicationController
  before_action :access_admin, only: %i[new create destroy edit]
  before_action :published_posts

  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user_id = current_user.id
    if @article.save
      redirect_to articles_path
      flash[:success] = "Article \"#{@article.title}\" with id:#{@article.id} has been succesfully created!"
    else
      flash.now[:warning] = 'Check requirements!'
      render :new
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to article_path(@article)
      flash[:success] = "News \"#{@article.title}\" with id:#{@article.id} has been edited"
    else
      flash.now[:warning] = 'Invalid parameters for editing!'
      render :edit
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy if @article.present?
    redirect_to articles_path
    flash[:danger] = "Article \"#{@article.title}\" with id:#{@article.id} has been deleted"
  end

  private

  def article_params
    params.require(:article).permit(:title, :short_description, :long_description, :image, :is_private, :is_visible)
  end

  def access_admin
    redirect_to root_path unless current_user&.admin?
  end
end
