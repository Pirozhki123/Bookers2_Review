class BookComment < ApplicationRecord
    belongs_to :user #userの子の要素
    belongs_to :book #bookの子の要素
    
    validates :comment, presence: true #commentの内容が空の場合許可しない
end
