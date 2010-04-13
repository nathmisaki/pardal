class Enrollment < ActiveRecord::Base
  belongs_to :student
  belongs_to :course
  belongs_to :situation, :class_name => "EnrollmentSituation"
end
