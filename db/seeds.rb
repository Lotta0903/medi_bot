puts "Cleaning database..."
Medication.destroy_all
User.destroy_all

puts "Creating user..."
user = User.create!(email: "test@medilink.com", password: "123456")

puts "Creating medications..."
Medication.create!(name: "Aspirin", dosage: "100mg", reminder_time: "08:00", user: user)
Medication.create!(name: "Vitamin D", dosage: "1000 IU", reminder_time: "12:00", user: user)
Medication.create!(name: "Penicillin", dosage: "500mg", reminder_time: "20:00", user: user)
Medication.create!(name: "Paracetamol", dosage: "1g", reminder_time: "08:00", user: user)

puts "Done! #{Medication.count} medications created."
