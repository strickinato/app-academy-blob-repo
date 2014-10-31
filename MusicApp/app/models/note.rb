class Note < ActiveRecord::Base
  validates :user_id, :track_id, :track_note, presence: true

  belongs_to(
    :author,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id
  )

  belongs_to(
    :track,
    class_name: "Track",
    foreign_key: :track_id,
    primary_key: :id
  )

end
