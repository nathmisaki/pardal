# == Schema Information
#
# Table name: schools
#
#  id             :integer(4)      not null, primary key
#  name           :string(120)
#  acronym        :string(15)
#  school_area_id :integer(4)
#  created_at     :datetime
#  updated_at     :datetime
#

class School < ActiveRecord::Base
  belongs_to :school_area
end
