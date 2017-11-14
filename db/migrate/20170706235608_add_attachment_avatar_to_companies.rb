class AddAttachmentAvatarToCompanies < ActiveRecord::Migration[5.0]
  def self.up
    change_table :companies do |t|
      t.attachment :companies, :avatar
    end
  end

  def self.down
    remove_attachment :companies, :avatar
  end
end
