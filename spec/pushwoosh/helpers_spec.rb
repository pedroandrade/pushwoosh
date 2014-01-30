require 'spec_helper'

describe Pushwoosh::Helpers do

  subject { Pushwoosh::Helpers::limit_string(('é' * 300), 256) }

  its(:size) { should == 128 }

end
