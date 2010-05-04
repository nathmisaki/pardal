class PreRequirement < ActiveRecord::Base
  belongs_to :implementation
  belongs_to :pre_requirement, :class_name => "Implementation"
end
