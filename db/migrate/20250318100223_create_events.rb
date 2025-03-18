class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.string :address
      t.datetime :date
      t.string :mood
      t.string :status
      t.string :description
      t.string :title
      t.integer :max_participants
      t.string :activity
      t.float :latitude
      t.float :longitude
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
