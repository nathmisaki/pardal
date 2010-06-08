# == Schema Information
#
# Table name: pre_requirements
#
#  id                 :integer(4)      not null, primary key
#  implementation_id  :integer(4)
#  pre_requirement_id :integer(4)
#  created_at         :datetime
#  updated_at         :datetime
#

class PreRequirement < ActiveRecord::Base
  belongs_to :implementation
  belongs_to :pre_requirement, :class_name => "Implementation"
end
