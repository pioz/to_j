class Book5 < ApplicationRecord
  self.table_name = :books
  belongs_to :author5

  def good_title
    self.title.titleize
  end
end
