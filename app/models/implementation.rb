class Implementation < ActiveRecord::Base
  belongs_to :curriculum
  belongs_to :discipline
  belongs_to :discipline_type
end
