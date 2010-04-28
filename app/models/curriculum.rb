class Curriculum < ActiveRecord::Base
  belongs_to :school
  belongs_to :period
  has_many :implementations
  has_many :disciplines, :through => :implementations
  has_many :courses, :through => :disciplines
end
