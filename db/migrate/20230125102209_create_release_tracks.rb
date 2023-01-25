class CreateReleaseTracks < ActiveRecord::Migration[7.0]
  def change
    create_table :release_tracks do |t|
      t.references :release, null: false
      t.references :track, null: false

      t.timestamps
    end
  end
end
