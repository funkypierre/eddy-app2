class CreateReleases < ActiveRecord::Migration[7.0]
  def change
    create_table :releases do |t|
      t.string :title
      t.string :upc
      t.integer :year
      t.references :artist, null: false

      t.timestamps
    end
  end
end
