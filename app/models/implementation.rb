class Implementation < ActiveRecord::Base
  has_many :pre_requirements
  belongs_to :curriculum
  belongs_to :discipline
  include EnumerateIt
  has_enumeration_for :discipline_type_id, :with => DisciplineType

  def discipline_type
    discipline_type_id_humanize
  end
end

