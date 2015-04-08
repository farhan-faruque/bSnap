class EditLookingForFromProfile < ActiveRecord::Migration
  def change
    #change_column :profiles, :lookingfor, :integer
    remove_column :profiles, :lookingfor
    add_column :profiles, :lookingfor, :integer, default: 0
  end
end
