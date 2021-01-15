require 'rails_helper'

RSpec.describe Account::Admin::UsersController, type: :controller do
  let!(:user) { create(:user, role: :admin) }
  let!(:valid_params) { attributes_for :user }
  let!(:invalid_params) { { username: ' ' } }

  before { sign_in user }

  describe 'GET#index' do
    before do
      get :index
    end

    it 'returns success and assigns user' do
      expect(response).to have_http_status(:success)
      expect(assigns(:user)) == user
    end
  end

  describe 'GET#edit' do
    before do
      get :edit, params: { id: user.id }
    end

    it 'returns http success and assign user' do
      expect(response).to have_http_status(:success)
      expect(assigns(:user)).to eq(user)
    end
  end

  describe 'User#create' do
    context 'when admin creates user with valid parameters' do
      subject { post :create, params: { user: valid_params } }

      it 'creates a new user' do
        expect { subject }.to change(User, :count).by(+1)
      end

      it { is_expected.to have_http_status(:redirect) }
    end

    context 'with invalid parameters' do
      subject { post :create, params: { user: invalid_params } }

      it 'not create a new user' do
        expect { subject }.to change(User, :count).by(0)
        expect(flash[:danger]).to be_present
      end
    end
  end

  describe 'PUT#update' do
    context 'with valid params' do
      before do
        put :update, params: { id: user.id,
                               user: valid_params.merge!(username: 'Example',
                                                         email: 'example@email.com') }
      end

      it 'assigns the user' do
        expect(assigns(:user)).to eq(user)
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(account_admin_users_path)
      end

      it 'updates user attributes' do
        user.reload
        expect(user.username).to eq(valid_params[:username])
        expect(user.email).to eq(valid_params[:email])
        expect(flash[:success]).to be_present
      end
    end

    context 'with invalid params' do
      it 'does not change user' do
        expect do
          put :update, params: { id: user.id, user: invalid_params }
        end.not_to change { user.reload.username }
      end
    end
  end

  describe 'DELETE#destroy' do
    it 'destroys the user' do
      expect { delete :destroy, params: { id: user.id } }
        .to change(User, :count).by(-1)
    end
  end
end
