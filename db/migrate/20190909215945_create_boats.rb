class CreateBoats < ActiveRecord::Migration[6.0]
  def change
    create_table :boats do |t|
      t.string :model
      t.integer :length
      t.st_point :lonlat, geographic: true

      t.timestamps
    end
    add_index :boats, :lonlat, using: :gist
  end
end
