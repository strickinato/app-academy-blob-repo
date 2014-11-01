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
end
