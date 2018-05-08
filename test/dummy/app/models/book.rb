class Book < ApplicationRecord
  include ToJ
  belongs_to :author

  def good_title
    self.title.titleize
  end
end
