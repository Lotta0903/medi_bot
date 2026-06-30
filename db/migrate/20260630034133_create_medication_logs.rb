class CreateMedicationLogs < ActiveRecord::Migration[8.1]
  def change
    create_table :medication_logs do |t|
      t.references :medication, null: false, foreign_key: true
      t.string :status
      t.datetime :taken_at

      t.timestamps
    end
  end
end
