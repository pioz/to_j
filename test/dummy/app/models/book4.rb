class Book4 < ApplicationRecord
  self.table_name = :books
  belongs_to :author4

  def good_title
    self.title.titleize
  end

  def self.to_builder
    Jbuilder.new do |json|
      json.array!(current_scope.map { |obj| obj.to_builder.attributes! })
    end.attributes!
  end

  def to_builder
    Jbuilder.new do |json|
      json.(self, :id, :title, :good_title)
    end.attributes!
  end
  
end
