class AddAttachmentAvatarToCompanies < ActiveRecord::Migration
  def self.up
    change_table :companies do |t|
      t.attachment :companies, :avatar
    end
  end

  def self.down
    remove_attachment :companies, :avatar
  end
end
