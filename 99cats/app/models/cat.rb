class Cat < ActiveRecord::Base
  validates :birth_date, :color, :name, :sex, :description, :user_id, presence: true
  validates :sex, inclusion: { in: %w(M F), messages: "%{value} is not a valid sex"}
  validates :color, inclusion: { in: %w(black white grey orange tabby pink), 
                                  messages: "%{value} is not a valid color"}
  validate :timeliness
  
  COLORS = ['black', 'white', 'grey', 'orange', 'tabby', 'pink']
  
  has_many(
    :rental_requests,
    primary_key: :id,
    foreign_key: :cat_id,
    class_name: 'CatRentalRequest',
    dependent: :destroy
  )
  
  belongs_to(
    :owner,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id
  )
  
  private
  def timeliness
    if birth_date != nil && birth_date > DateTime.current
      errors[:birth_date] << "can't be in the future!"
    end
  end
end
