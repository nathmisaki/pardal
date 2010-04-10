class Curriculum < ActiveRecord::Base
  belongs_to :school
  belongs_to :period
end
