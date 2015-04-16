class RemovePaperclipImage < ActiveRecord::Migration

  AttachmentColumns = [["file_name", :string], ["content_type", :string], ["file_size", :integer],['updated_at', :datetime]]
  AttachmentPath = Rails.root.join("public", "system")

  def self.remove_attachment(table, name)
    AttachmentColumns.each do |suffix, type|
      remove_column table, "#{name}_#{suffix}"
    end
    FileUtils.rm_r AttachmentPath.join(table.to_s, name.to_s.pluralize), :force => true, :secure => true
  end

  def self.add_attachment(table, name)
    AttachmentColumns.each do |suffix, type|
      add_column table, "#{name}_#{suffix}", type
    end
  end

  def self.up
    remove_attachment :posts, :image

  end

  def self.down
    add_attachment :users, :image
  end
end
