class Album < ActiveRecord::Base
  RECORDING_TYPES = ['live', 'studio']

  validates :title, presence: true, uniqueness: true
  validates :band_id, :recording_type, presence: true
  validates :recording_type, inclusion: RECORDING_TYPES


  belongs_to(
    :band,
    class_name: "Band",
    foreign_key: :band_id,
    primary_key: :id,
  )

  has_many(
    :tracks,
    class_name: "Track",
    foreign_key: :album_id,
    primary_key: :id,
    dependent: :destroy
  )
end
