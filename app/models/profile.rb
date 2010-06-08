# == Schema Information
#
# Table name: profiles
#
#  id          :integer(4)      not null, primary key
#  description :text
#  user_id     :integer(4)
#  created_at  :datetime
#  updated_at  :datetime
#

class Profile < ActiveRecord::Base
  belongs_to :user
end
