# == Schema Information
#
# Table name: attachments
#
#  id              :integer(4)      not null, primary key
#  attachable_type :string(30)
#  attachable_id   :integer(4)
#  file_name       :string(100)
#  content_type    :string(50)
#  file_size       :integer(4)
#  data            :binary
#  created_at      :datetime
#  updated_at      :datetime
#

class Attachment < ActiveRecord::Base
  belongs_to :attachable, :polymorphic => true

  attr_accessor :uploaded_file

  def uploaded_file=(incoming_file)
    self.file_name = incoming_file.original_filename
    self.content_type = incoming_file.content_type
    self.data = incoming_file.read
  end

  def filename=(new_filename)
    write_attribute("filename", sanitize_filename(new_filename))
  end

  private
  def sanitize_filename(filename)
    #get only the filename, not the whole path (from IE)
    just_filename = File.basename(filename)
    #replace all non-alphanumeric, underscore or periods with underscores
    just_filename.gsub(/[^\w\.\-]/, '_')
  end
end
