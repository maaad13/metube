
class CreateWatchCounts < ActiveRecord::Migration[7.1]
  def change
    create_table :watch_counts do |t|
      t.references :video, null: false, foreign_key: true
      t.string :ip_address, null: false

      t.timestamps
    end
    add_index :watch_counts, [:video_id, :ip_address], unique: true
  end
end