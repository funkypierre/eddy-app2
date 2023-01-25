class CreateSales < ActiveRecord::Migration[7.0]
  def change
    create_table :sales do |t|
      t.references :product, polymorphic: true, null: false
      t.references :artist, null: false
      t.string  :transaction_type
      t.float   :net_share
      t.float   :label_share
      t.float   :artist_share

      t.timestamps
    end
  end
end
