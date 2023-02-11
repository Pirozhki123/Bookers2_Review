class Relationship < ApplicationRecord
  belongs_to :follower, class_name: "User" #followerはuserの子の要素
  belongs_to :followed, class_name: "User" #followedはuserの子の要素
end
