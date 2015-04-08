class EditLookingForFromProfile < ActiveRecord::Migration
  def change
    change_column :profiles, :lookingfor, :integer
  end
end
