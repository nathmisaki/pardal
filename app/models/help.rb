# == Schema Information
#
# Table name: helps
#
#  id         :integer(4)      not null, primary key
#  page       :string(100)
#  text       :text
#  created_at :datetime
#  updated_at :datetime
#

class Help < ActiveRecord::Base
  def self.find_page(page_name)
    self.find_by_page(page_name.gsub(/-[\d]+-/, '-#-'))
  end
end
