class Article < ApplicationRecord
  belongs_to :user

  validates :long_description, :short_description, :title, presence: true
  validate :image_size_validation

  scope :visible, -> { where(is_visible: true) }
  scope :public_posts, -> { where(is_private: false) }
  scope :ordered, -> { order('created_at DESC') }

  mount_uploader :image, ImageUploader

  paginates_per 5

  private

  def image_size_validation
    errors[:image] << "Should be less than 2MB" if image.size > 2.megabytes
  end
end
