class Book < ApplicationRecord
  belongs_to :user
  has_many :book_comments, dependent: :destroy #book_commentsの親の要素。book削除と一緒に消す。
  has_many :favorites, dependent: :destroy
  
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}
  
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists? #favが押されているかどうかを確認
  end
end
