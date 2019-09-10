require 'test_helper'

class ToJ::Test < ActiveSupport::TestCase
  test 'exist ToJ module' do
    assert_kind_of Module, ToJ
    assert_not_nil ToJ::VERSION
    assert_equal '0.4.0', ToJ::VERSION
  end

  test 'author default json' do
    author = create(:author, name: 'Enrico')
    expected_json = { 'id' => author.id, 'name' => author.name }
    assert_equal expected_json, author.to_j
  end

  test 'author with all fields' do
    author = create(:author, name: 'Enrico')
    expected_json = { 'id' => author.id, 'name' => author.name, 'created_at' => author.created_at, 'updated_at' => author.updated_at }
    assert_equal expected_json, author.to_j(view: :all_fields)
  end

  test 'author with books' do
    book_titles = ['MySQL performance', 'Harry Potter']
    author = create(:author, name: 'Enrico', book_titles: book_titles)
    expected_json = {
      'id' => author.id,
      'name' => author.name,
      'books' => [
        { 'id' => author.books.first.id, 'title' => author.books.first.title, 'nice_title' => author.books.first.nice_title },
        { 'id' => author.books.last.id, 'title' => author.books.last.title, 'nice_title' => author.books.last.nice_title }
      ]
    }
    assert_equal expected_json, author.to_j(view: :with_books)
  end

  test 'works also without serializer' do
    comment = create(:comment)
    expected_json = { 'id' => comment.id, 'text' => comment.text, 'created_at' => comment.created_at, 'updated_at' => comment.updated_at }
    assert_equal expected_json, comment.to_j
  end

  test 'not existing view' do
    author = create(:author)
    error = assert_raise StandardError do
      author.to_j(view: :unicorns_and_popcorns)
    end
    assert_equal 'Serializer view :unicorns_and_popcorns does not exist!', error.message
  end

  test 'to_j works on ActiveRecord::Relation' do
    author1 = create(:author)
    author2 = create(:author)
    expected_json = [
      { 'id' => author2.id, 'name' => author2.name },
      { 'id' => author1.id, 'name' => author1.name }
    ]
    assert_equal expected_json, Author.order(id: :desc).limit(2).to_j
  end
end
