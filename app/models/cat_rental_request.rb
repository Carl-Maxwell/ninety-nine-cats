class CatRentalRequest < ActiveRecord::Base
  STATUSES = [
    "PENDING",
    "APPROVED",
    "DENIED"
  ]

  validates :cat_id, :start_date, :end_date, :status, presence: true
  validates :status, inclusion: STATUSES
  validate :overlapping_approved_requests, unless: :denied?
  validate :dates_in_correct_order

  belongs_to :cat

  after_initialize :status_pending

  def approve!
    raise "Status must be PENDING" if self.status != "PENDING"

    transaction do
      overlapping_requests.each(&:deny!)

      self.status = "APPROVED"
      save!
    end
  end

  def deny!
    self.status = "DENIED"
    save!
  end

  private

  def overlapping_requests
    overlapping_requests = CatRentalRequest
      .where(cat_id: cat_id)
      .where("id != ?", id)
      .where(<<-SQL, start_date: start_date, end_date: end_date)
        (start_date BETWEEN :start_date AND :end_date
        OR
        end_date BETWEEN :start_date AND :end_date)
        OR
        (start_date < :start_date AND end_date > :end_date)
      SQL
  end

  def overlapping_approved_requests
    if overlapping_requests.where(status: "APPROVED").any?
      errors[:start_date] << "overlaps with another request"
    end
  end

  def status_pending
    self.status ||= "PENDING"
  end

  def denied?
    status == "DENIED"
  end

  def dates_in_correct_order
    if start_date > end_date
      errors[:start_date] << "must come before end date"
    end
  end
end
