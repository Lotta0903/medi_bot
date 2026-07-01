class AddContentToMedications < ActiveRecord::Migration[8.1]
  def change
    add_column :medications, :content, :text
  end
end
