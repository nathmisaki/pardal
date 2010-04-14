class Curriculum < ActiveRecord::Base
  belongs_to :school
  belongs_to :period
  has_many :implementations
end
