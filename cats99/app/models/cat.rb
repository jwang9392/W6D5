# == Schema Information
#
# Table name: cats
#
#  id          :bigint           not null, primary key
#  birth_date  :date             not null
#  color       :string           not null
#  name        :string           not null
#  sex         :string           not null
#  description :text             default(""), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require 'date'
require 'action_view'
require 'action_view/helpers'

class Cat < ApplicationRecord

  COLORS = ["black", "brown", "golden", "rainbow", "other"]

  include ActionView::Helpers::DateHelper

  validates :birth_date, :color, :name, :sex, :description, presence: true
  validates :color, inclusion: { in: COLORS, message: "%{value} is not a valid color" }
  validate :valid_date 

  def age
    ((DateTime.now.year * 12 + DateTime.now.mon) - (birth_date.year * 12 + birth_date.mon)) / 12.0
  end

  def valid_date
    if birth_date > DateTime.now.strftime('%Y/%m/%d').to_date
      # raise 'Cat does not exist yet'
      errors[:birth_date] << 'is in the future.'
    end
  end

end
