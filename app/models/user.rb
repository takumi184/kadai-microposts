class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
  format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
  uniqueness: { case_sensitive: false }
  has_secure_password
  
  has_many :microposts
  has_many :favorites
  has_many :Micropostings, through: :favorites, source: :micropost # ＜＝ この行
  has_many :reverses_of_favorites, class_name: 'Favorite' , foreign_key: 'micropost_id'
  has_many :Microposters, through: :reverses_of_favorites, source: :user # ＜＝ この行
  
  def favorite(other_user)
    unless self == other_user
      self.favorites.find_or_create_by(micropost_id: other_user.id)
    end
  end
  
  def unfavorite(other_user)
    favorites = self.favorites.find_by(micropost_id: other_user.id)
    favorites.destroy if favorites
  end
  
  def favoriteing?(other_user)
    self.favoritings.include?(other_user)
  end
  
end
