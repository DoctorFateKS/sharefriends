class CreateProfiles < ActiveRecord::Migration[7.1]
  def change
    create_table :profiles do |t|
      t.string :first_name
      t.string :last_name
      t.string :mood
      t.string :hobbie
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
