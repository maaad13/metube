class CreateVideos < ActiveRecord::Migration[7.1]
  def change
    create_table :videos do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.string :description
      t.string :file

      t.timestamps
    end
  end
end
