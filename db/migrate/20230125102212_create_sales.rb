class CreateSales < ActiveRecord::Migration[7.0]
  def change
    create_table :sales do |t|
      t.references :product, polymorphic: true
      t.string  :transaction_type
      t.float   :label_share
      t.float   :artist_share

      t.timestamps
    end
  end
end
