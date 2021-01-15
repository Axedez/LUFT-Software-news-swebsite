require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do
  render_views

  let!(:admin) { create(:user, role: :admin) }
  let!(:article) { create(:article, is_visible: true) }
  let!(:valid_params) { attributes_for :article }
  let!(:invalid_params) { { title: '' } }

  before { sign_in admin }

  describe 'GET index' do
    it 'has a 200 status code' do
      get :index
      expect(response.status).to eq(200)
    end
  end

  describe 'GET#show' do
    before do
      get :show, params: { reference: article.reference }
    end

    it 'returns success and assigns article' do
      expect(response).to have_http_status(:success)
      expect(assigns(:article)).to eq(article)
    end
  end

  describe 'GET#new' do
    it 'returns success and assigns article' do
      get :new
      expect(response).to have_http_status(:success)
      expect(assigns(:article)).to be_a_new(Article)
    end
  end

  describe 'POST#create' do
    context 'with valid params' do
      it 'creates a new article' do
        expect do
          post :create, params: { article: valid_params }
        end.to change(Article, :count).by(1)
      end

      it 'redirects to article index path' do
        post :create, params: { article: valid_params }
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(articles_path)
      end
    end

    context 'with invalid params' do
      it 'do not create a new article' do
        expect do
          post :create, params: { article: invalid_params }
        end.not_to change(Article, :count)
      end
    end
  end

  describe 'PUT#update' do
    context 'with valid params' do
      before do
        sign_in admin
        put :update, params: { reference: article.reference,
                               article: valid_params.merge!(title: 'Test',
                                                            short_description: 'New description',
                                                            long_description: '<p>New text</p>')
                              }
      end

      it 'redirect the article' do
        expect(assigns(:article)).to eq(article)
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(article_path(article))
      end

      it 'updates article attributes' do
        article.reload
        expect(article.title).to eq(valid_params[:title])
        expect(article.short_description).to eq(valid_params[:short_description])
        expect(article.long_description).to eq(valid_params[:long_description])
        expect(flash[:success]).to be_present
      end
    end

    context 'with invalid params' do
      it 'does not change news' do
        expect do
          put :update, params: { reference: article.reference, article: invalid_params }
        end.not_to change { article.reload.title }
      end
    end
  end

  describe 'DELETE#destroy' do
    it 'destroys the article and redirects to index' do
      expect { delete :destroy, params: { reference: article.reference } }
        .to change(Article, :count).by(-1)
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(articles_path)
      expect(flash[:danger]).to be_present
    end
  end
end
