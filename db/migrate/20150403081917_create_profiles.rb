class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.boolean :lookingfor
      t.integer :location_id
      t.string :mobile_no
      t.boolean :mobile_private

      t.timestamps null: false
    end
  end
end
