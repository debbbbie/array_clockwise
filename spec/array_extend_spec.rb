require 'spec_helper'

describe Array do
  it "#before" do
    [].before(0).should be(nil)
    [].before(1).should be(nil)
    [0,1,2].before(0).should be(nil)
    [0,1,2].before(2).should be(1)
  end
end