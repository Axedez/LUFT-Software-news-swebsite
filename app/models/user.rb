class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: %i[simple admin]
  has_many :articles, dependent: :nullify

  validates :username, presence: true, length: { maximum: 50 }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true, length: { maximum: 255 }

  paginates_per 10
end
