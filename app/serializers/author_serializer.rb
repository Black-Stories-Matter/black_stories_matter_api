class AuthorSerializer
  include FastJsonapi::ObjectSerializer

  set_type :author
  set_id :id
  attributes :name

end
