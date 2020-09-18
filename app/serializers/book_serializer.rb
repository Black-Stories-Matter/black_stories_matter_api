class BookSerializer
  include FastJsonapi::ObjectSerializer
  set_type :book
  set_id :id
  attributes :isbn,
             :title,
             :cover_image,
             :description,
             :publication_date,
             :category,
             :maturity,
             :info_link,
             :authors 
end
