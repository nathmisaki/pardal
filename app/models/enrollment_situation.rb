# == Schema Information
#
# Table name: enrollment_situations
#
#  id          :integer(4)      not null, primary key
#  description :string(255)
#  active      :boolean(1)
#  created_at  :datetime
#  updated_at  :datetime
#

class EnrollmentSituation < ActiveRecord::Base
end
