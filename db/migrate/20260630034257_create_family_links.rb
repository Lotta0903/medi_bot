class CreateFamilyLinks < ActiveRecord::Migration[8.1]
  def change
    create_table :family_links do |t|
      t.references :user, null: false, foreign_key: true
      t.references :member, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
