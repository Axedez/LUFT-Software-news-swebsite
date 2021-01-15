class Article < ApplicationRecord
  belongs_to :user
  before_validation :set_reference

  validates :long_description, :short_description, :title, presence: true
  validate :image_size_validation

  scope :visible, -> { where(is_visible: true) }
  scope :public_posts, -> { where(is_private: false) }
  scope :ordered, -> { order('created_at DESC') }

  mount_uploader :image, ImageUploader

  paginates_per 5

  def to_param
    reference
  end

  private

  def image_size_validation
    errors[:image] << "Should be less than 5MB" if image.size > 5.megabytes
  end

  def random_strings
    source = ('a'..'z').to_a + ('A'..'Z').to_a
    key = ''
    3.times { key += source[rand(source.size)].to_s }
    key
  end

  def random_digits
    rand(100..999).to_s
  end

  def set_reference
    self.reference = 2.times.collect { random_strings + random_digits }.join('') + random_strings unless reference
  end
end
