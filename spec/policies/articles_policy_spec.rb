require 'rails_helper'

RSpec.describe ArticlePolicy, type: :policy do
  subject { described_class }

  let!(:admin) { create(:user, role: :admin) }
  let!(:simple) { create(:user, role: :simple) }

  permissions :create?, :new?, :update?, :edit?, :destroy? do
    it 'denies access if user is simple' do
      expect(subject).not_to permit(simple)
    end

    it 'grants access if user is admin' do
      expect(subject).to permit(admin)
    end
  end
end
