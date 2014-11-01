class Postsub < ActiveRecord::Base
  validates :post_id, :sub_id, presence: true
  
  belongs_to(
    :post,
    class_name: "Post",
    foreign_key: :post_id,
    primary_key: :id
  )
  
  belongs_to(
    :sub,
    class_name: "Sub",
    foreign_key: :sub_id,
    primary_key: :id
  )
  
  def self.add_subs_from_new_posts(subs, post_id)
    subs.each do |sub_id|
      Postsub.create!(sub_id: sub_id.to_i, post_id: post_id.to_i)
    end
  end
end