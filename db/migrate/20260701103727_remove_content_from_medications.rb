class RemoveContentFromMedications < ActiveRecord::Migration[8.1]
  def change
    remove_column :medications, :content, :text
  end
end
