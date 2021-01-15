require 'rails_helper'

RSpec.describe Article, type: :model do
  let!(:article) { FactoryBot.build(:article) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:short_description) }
    it { is_expected.to validate_presence_of(:long_description) }

    describe 'image' do
      it 'reject image that has more than 1.5 mb' do
        file = File.open(File.join(Rails.root, 'spec/support/images/image-3mb.jpg'))
        article.image = file
        allow(article.image).to receive(:size).and_return(6.megabytes)
        article.valid?
        expect(article.errors[:image]).to include("Should be less than 5MB")
      end
    end

    context 'when image is not correct format' do
      file = File.open(File.join(Rails.root, 'spec/support/images/image-3mb.txt'))
      it { is_expected.not_to allow_value(file).for(:image) }
    end
  end

  describe 'Associations' do
    it { is_expected.to belong_to(:user) }
  end
end
