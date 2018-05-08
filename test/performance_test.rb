require 'test_helper'
require 'benchmark'

class ToJ::Test < ActiveSupport::TestCase

  test "generate_authors_with_books_json" do
    authors  = Author.includes(:books)
    authors2 = Author2.includes(:books)
    authors3 = Author3.includes(:books)
    authors4 = Author4.includes(:books)
    json  = nil
    json2 = nil
    json3 = nil
    json4 = nil
    Benchmark.bm do |x|
      x.report("to_j\t")    {  json = authors.to_j(view: :with_books) }
      x.report("as_json\t") { json2 = authors2.as_json }
      x.report("ams\t")     { json3 = ActiveModelSerializers::SerializableResource.new(authors3, each_serializer: Author3WithBooksSerializer).as_json }      
      x.report("jbuilder")  { json4 = authors4.to_builder }
    end
    assert_equal json, json2
    assert_equal json, json3.map(&:deep_stringify_keys)
    assert_equal json, json4
  end

end
