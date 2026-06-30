class CreateMedications < ActiveRecord::Migration[8.1]
  def change
    create_table :medications do |t|
      t.string :name
      t.string :dosage
      t.string :reminder_time
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
