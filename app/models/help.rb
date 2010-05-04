class Help < ActiveRecord::Base
  def self.find_page(page_name)
    self.find_by_page(page_name.gsub(/-[\d]+-/, '-#-'))
  end
end
