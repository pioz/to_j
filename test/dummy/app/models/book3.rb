class Book3 < ApplicationRecord
  self.table_name = :books
  belongs_to :author3

  def good_title
    self.title.titleize
  end
end
