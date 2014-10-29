class CatRentalRequest < ActiveRecord::Base
  validates :cat_id, :start_date, :end_date, :status, :user_id, presence: true
  validates :status, inclusion: { in: %w(PENDING APPROVED DENIED), 
            messages: "not a valid status" }
  validate :cannot_rent_cat_at_the_same_time
  validate :start_date_cannot_be_after_end_date
  
  belongs_to(
    :cat,
    primary_key: :id,
    foreign_key: :cat_id,
    class_name: 'Cat'
  )
  
  belongs_to(
    :requester,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id
  )

  
  def approve!
    self.status = "APPROVED"
    self.save!

    overlapping_pending_requests.each do |request|
      request.deny!
    end
  end
  
  def deny!
    self.status = "DENIED"
    self.save!
  end
  
  private
  def overlapping_requests
    overlapping = CatRentalRequest
     .where("id != ?", self.id)
     .where("cat_id = ?", self.cat_id)
     .where("(start_date BETWEEN ? AND ?) OR (end_date BETWEEN ? AND ?)", 
           self.start_date, self.end_date, self.start_date, self.end_date)
  end
  
  def overlapping_approved_requests
    overlapping_requests.where("status = 'APPROVED'")
  end
  
  def overlapping_pending_requests
    overlapping_requests.where("status = 'PENDING'")
  end

  def cannot_rent_cat_at_the_same_time
    if overlapping_approved_requests.count > 0 && self.status != "DENIED"
      errors[:cat_id] << "cat cannot be rented twice at the same time!"
    end
  end
  
  def start_date_cannot_be_after_end_date
    if self.start_date > self.end_date
      errors[:dates] << "start date cannot be after the end date"
    end
  end
end
