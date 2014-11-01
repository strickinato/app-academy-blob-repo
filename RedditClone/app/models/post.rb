class Post < ActiveRecord::Base
  validates :title, :author_id, presence: true
  
  belongs_to(
    :author,
    class_name: "User",
    foreign_key: :author_id,
    primary_key: :id
  )
  
  has_many(
    :postsubs,
    class_name: "Postsub",
    foreign_key: :sub_id,
    primary_key: :id
  )
  
  has_many(
    :subs,
    through: :postsubs,
    source: :sub
  )
  
  has_many(
    :comments,
    class_name: "Comment",
    foreign_key: :post_id,
    primary_key: :id,
    dependent: :destroy
  )
end
