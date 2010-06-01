require "spec_helper"

describe LayoutHelper do
  context "calling #title" do
    before(:each) { helper.title('TESTE do #title', true) }

    it { assigns[:content_for_title].should == 'TESTE do #title' }

    it { helper.show_title?.should == true }
  end

  it "calling #stylesheet" do
    helper.should_receive(:content_for).with(:head, stylesheet_link_tag('teste_stylesheet') )
    helper.stylesheet('teste_stylesheet')
  end

  it "calling #javascript" do
    helper.should_receive(:content_for).with(:head, javascript_include_tag('teste_javascript') )
    helper.javascript('teste_javascript')
  end

end
