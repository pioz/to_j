class Author4 < ApplicationRecord
  self.table_name = :authors
  has_many :books, dependent: :destroy, foreign_key: :author_id, class_name: 'Book4'

  def self.to_builder
    Jbuilder.new do |json|
      json.array!(current_scope.map { |obj| obj.to_builder })
    end.attributes!
  end

  def to_builder
    Jbuilder.new do |json|
      json.(self, :id, :name)
      json.books do
        json.array!(self.books.map(&:to_builder))
      end
    end.attributes!
  end
  
end
