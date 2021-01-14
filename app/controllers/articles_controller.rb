class ArticlesController < ApplicationController
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  before_action :published_article, except: %i[new create]
  before_action :authorize_article, except: %i[index show]

  def index; end

  def show
    @article = @articles.find_by!(reference: params[:reference])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user_id = current_user.id
    if @article.save
      redirect_to articles_path
      flash[:success] = "Article \"#{@article.title}\" with reference:#{@article.reference} has been succesfully created!"
    else
      flash.now[:warning] = 'Check requirements!'
      render :new
    end
  end

  def edit
    @article = @articles.find_by!(reference: params[:reference])
  end

  def update
    @article = @articles.find_by!(reference: params[:reference])
    if @article.update(article_params)
      redirect_to article_path(@article)
      flash[:success] = "News \"#{@article.title}\" with id:#{@article.id} has been edited"
    else
      flash.now[:warning] = 'Invalid parameters for editing!'
      render :edit
    end
  end

  def destroy
    @article = @articles.find_by!(reference: params[:reference])
    @article.destroy if @article.present?
    redirect_to articles_path
    flash[:danger] = "Article \"#{@article.title}\" with id:#{@article.id} has been deleted"
  end

  private

  def article_params
    params.require(:article).permit(:title, :short_description, :long_description, :image, :is_private, :is_visible)
  end

  def user_not_authorized
    flash[:alert] = 'You are not authorized to perform this action.'
    redirect_to(request.referer || root_path)
  end

  def published_article
    @articles = current_user&.admin? ? Article.all : Article.all.visible
    @articles = user_signed_in? ? @articles : @articles.public_posts
    @articles = @articles.ordered.page params[:page]
  end

  def authorize_article
    authorize :article
  end
end
