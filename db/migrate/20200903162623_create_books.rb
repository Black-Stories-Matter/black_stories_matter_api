class CreateBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :books do |t|
      t.string :isbn
      t.string :title
      t.string :cover_image
      t.text :description
      t.string :publication_date
      t.string :category
      t.string :maturity
      t.string :info_link

      t.timestamps
    end
  end
end
