class User < ApplicationRecord
  before_create :confirmation_token
  mount_uploader :card, CardUploader
  has_secure_password
  has_many :joins, dependent: :destroy
  has_many :groups, through: :joins

  has_many :meetings, through: :groups
  
  has_many :comments

  has_many :posts
  has_many :likes
  has_many :liked_posts, through: :likes, source: :post


  def email_activate
      self.email_confirmed = true
      self.confirm_token = nil
      save!(:validate => false)
  end
  
  def is_like?(post)
    Like.find_by(user_id: self.id, post_id: post.id).present?
  end

  private
  def confirmation_token
    if self.confirm_token.blank?
        self.confirm_token = SecureRandom.urlsafe_base64.to_s
    end
  end
end
