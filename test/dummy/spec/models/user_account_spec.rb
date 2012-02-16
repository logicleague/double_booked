require 'spec_helper'

describe UserAccount do

  it { should belong_to(:owner) }

end
