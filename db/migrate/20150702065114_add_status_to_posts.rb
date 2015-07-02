class AddStatusToPosts < ActiveRecord::Migration

  def change
    add_column :posts, :status, :string
    add_column :posts, :deadline, :date
    add_column :posts, :starts_at, :date
    add_column :posts, :ends_at, :date
  end
end
