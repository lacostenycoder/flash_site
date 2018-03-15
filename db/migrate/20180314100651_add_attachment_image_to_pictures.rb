class AddAttachmentImageToPictures < ActiveRecord::Migration[5.2]
  def change
    create_table :images do |t|
      t.references :deal
      t.attachment :attachment
    end
  end
end
