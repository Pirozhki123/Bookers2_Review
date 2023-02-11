class Book < ApplicationRecord
  belongs_to :user
  has_many :book_comments, dependent: :destroy #book_commentsの親の要素。book削除と一緒に消す。
  has_many :favorites, dependent: :destroy

  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists? #favが押されているかどうかを確認
  end

  def self.search_for(content, method)
    if method == 'perfect' #検索条件がperfectの場合
      Book.where(title: content) #bookモデルから検索ワードとtitleが完全に一致するものを検索
    elsif method == 'forward' #検索条件がforwardの場合
      Book.where('title LIKE ?', content+'%') #bookモデルから検索ワードとtitleが前方一致するものを検索
    elsif method == 'backward' #検索条件がbackwordの場合
      Book.where('title LIKE ?', '%'+content) #bookモデルから検索ワードとtitleが後方一致するものを検索
    else #それ以外の場合
      Book.where('title LIKE ?', '%'+content+'%') #bookモデルから検索ワードとtitleが部分一致するものを検索
    end
  end
end
