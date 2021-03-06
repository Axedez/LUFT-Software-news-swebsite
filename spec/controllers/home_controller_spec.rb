require 'rails_helper'
RSpec.describe HomeController, type: :controller do
  describe '#index' do
    subject { get :index }

    it { is_expected.to redirect_to(articles_path) }
  end
end
