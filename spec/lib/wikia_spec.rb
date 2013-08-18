require File.dirname(__FILE__) + '/../spec_helper'

describe Wikia, ".find" do
  it "should return a Wikia::Page instance" do
    page = Wikia.find('Getting_Things_Done')
    page.should be_an_instance_of(Wikia::Page)
  end
  
  it "should return a Page with a title" do
    page = Wikia.find('Getting_Things_Done')
    page.title.should_not be_nil
  end
  
  it "should return a Page given a URL" do
    page1 = Wikia.find('Getting_Things_Done')
    
    page2 = Wikia.find('http://en.wikia.org/wiki/Getting_Things_Done')
    page1.title.should == page2.title
  end
end