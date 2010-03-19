require 'spec_helper'

describe Anexo do
  before(:each) do
    @valid_attributes = {
      :anexo_file_name => "value for anexo_file_name",
      :anexo_content_type => "value for anexo_content_type",
      :anexo_file_size => 1,
      :anexo_updated_at => Time.now
    }
  end

  it "should create a new instance given valid attributes" do
    Anexo.create!(@valid_attributes)
  end
end
