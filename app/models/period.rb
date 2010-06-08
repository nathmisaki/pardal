# == Schema Information
#
# Table name: periods
#
#  id         :integer(4)      not null, primary key
#  name       :string(15)
#  created_at :datetime
#  updated_at :datetime
#

class Period < ActiveRecord::Base
end
