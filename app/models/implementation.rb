class Implementation < ActiveRecord::Base
  has_many :pre_requirements
  belongs_to :curriculum
  belongs_to :discipline
  belongs_to :discipline_type
end
