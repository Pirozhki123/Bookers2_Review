class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books
  has_many :book_comments, dependent: :destroy #book_commentsの親の要素。user削除と一緒に消す。
  has_many :favorites, dependent: :destroy #favoritesの親の要素。user削除と一緒に消す。

  # 自分がフォローされる（被フォロー）側の関係性
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # 被フォロー関係を通じて参照→自分をフォローしている人
  has_many :followers, through: :reverse_of_relationships, source: :follower

  # 自分がフォローする（与フォロー）側の関係性
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  # 与フォロー関係を通じて参照→自分がフォローしている人
  has_many :followings, through: :relationships, source: :followed

  has_one_attached :profile_image

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }


  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end

  def follow(user)
    relationships.create(followed_id: user.id) #渡されたユーザーのIDでフォローをfollowed_idをクリエイト
  end

  def unfollow(user)
    relationships.find_by(followed_id: user.id).destroy #渡されたユーザーのIDでfollowed_idを探して削除
  end

  def following?(user)
    followings.include?(user) #自分がフォローしているかしていないかの判別
  end

  def self.search_for(content, method)
    if method == 'perfect' #検索条件がperfectの場合
      User.where(name: content) #ユーザーモデルから検索ワードとnameが完全に一致するものを検索
    elsif method == 'forward' #検索条件がforwardの場合
      User.where('name LIKE ?', content + '%') #ユーザーモデルから検索ワードとnameが前方一致するものを検索
    elsif method == 'backward' #検索条件がbackwordの場合
      User.where('name LIKE ?', '%' + content) #ユーザーモデルから検索ワードとnameが後方一致するものを検索
    else #それ以外の場合
      User.where('name LIKE ?', '%' + content + '%') #ユーザーモデルから検索ワードとnameが部分一致するものを検索
    end
  end
end
