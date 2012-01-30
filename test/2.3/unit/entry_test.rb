require File.expand_path(__FILE__ + '/../../helper')

class EntryTest < ActiveSupport::TestCase

  def setup
    load_models
  end

  test "don't allow update" do
    entry = Entry.first
    assert_raise(ActiveRecord::ReadOnlyRecord) { entry.save }
  end

end
