class HomeController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  def index
    redirect_to articles_path
  end
end
