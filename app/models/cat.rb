require 'action_view'
require 'action_view/helpers'

class Cat < ActiveRecord::Base
  include ActionView::Helpers::DateHelper

  COLORS = [
    "green",
    "blue"
  ]

  SEXES = [
    "M",
    "F"
  ]

  validates :birth_date, :name, presence: true
  validates :color, inclusion: COLORS
  validates :sex, inclusion: SEXES

  has_many(
    :rental_requests,
    class_name: :CatRentalRequest,
    dependent: :destroy
  )

  def age
    time_ago_in_words(birth_date)
  end
end
