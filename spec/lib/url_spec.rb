require File.dirname(__FILE__) + '/../spec_helper'

describe Wikia::Url, "like http://en.wikia.org/wiki/Getting_Things_Done" do
  it "should have a title of Getting_Things_Done" do
    url = Wikia::Url.new('http://en.wikia.org/wiki/Getting_Things_Done')
    url.title.should == 'Getting_Things_Done'
  end
end