# == Schema Information
#
# Table name: implementations
#
#  id                 :integer(4)      not null, primary key
#  curriculum_id      :integer(4)
#  discipline_id      :integer(4)
#  school_semester    :integer(4)
#  discipline_type_id :integer(4)
#  created_at         :datetime
#  updated_at         :datetime
#

class Implementation < ActiveRecord::Base
  has_many :pre_requirements
  belongs_to :curriculum
  belongs_to :discipline
  include EnumerateIt
  has_enumeration_for :discipline_type_id, :with => DisciplineType

  alias :discipline_type :discipline_type_id_humanize
end

