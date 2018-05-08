require 'test_helper'

class ToJ::Test < ActiveSupport::TestCase
  test "truth" do
    assert_kind_of Module, ToJ
  end

  test "author_json" do
    author = create(:author, name: 'Enrico')
    json = author.to_j
    assert_equal 'Enrico', json['name']
    assert_not_nil json['id']
    assert_nil json['updated_at']
  end

end
