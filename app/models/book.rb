class Book < ApplicationRecord
  validates_presence_of :isbn, :title
  belongs_to :author 
end
