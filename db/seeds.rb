# Limpiar las tablas existentes
Appointment.destroy_all
Service.destroy_all
Condition.destroy_all
Disease.destroy_all
Allergy.destroy_all
Allergen.destroy_all
Vaccination.destroy_all
Vaccine.destroy_all
Pet.destroy_all
Veterinary.destroy_all
User.destroy_all

# Crear usuarios normales
user1 = User.create!(
  first_name: 'Valentina',
  last_name: 'León',
  email: 'valentina@gmail.com',
  phone_number: '951 579 8853',
  address: '123 Elm St, Springfield',
  password: "password"
)
user2 = User.create!(
  first_name: 'Camila',
  last_name: 'Acevedo',
  email: 'camila@gmail.com',
  phone_number: '951 579 2954',
  address: '456 Maple Ave, Rivertown',
  password: "password"
)
user3 = User.create!(
  first_name: 'Diana',
  last_name: 'Pérez',
  email: 'diana@gmail.com',
  phone_number: '951 579 2955',
  address: '789 Oak Dr, Greenfield',
  password: "password"
)
user4 = User.create!(
  first_name: 'Mariana',
  last_name: 'Gómez',
  email: 'mariana@gmail.com',
  phone_number: '951 579 2956',
  address: '101 Pine Rd, Pleasantville',
  password: "password"
)
user5 = User.create!(
  first_name: 'María',
  last_name: 'Orendain',
  email: 'maria@gmail.com',
  phone_number: '951 579 2957',
  address: '202 Cedar St, Lakeview',
  password: "password"
)

# Crear usuarios adicionales que serán veterinarios
user6 = User.create!(
  first_name: 'Lilian',
  last_name: 'Padilla',
  email: 'lilian@gmail.com',
  phone_number: '951 579 2958',
  address: '303 Birch Ave, Hillside',
  password: 'password'
)
user7 = User.create!(
  first_name: 'Ana',
  last_name: 'García',
  email: 'ana@gmail.com',
  phone_number: '951 579 2959',
  address: '404 Spruce Dr, Oceanview',
  password: "password"
)

# Crear veterinarios a partir de algunos usuarios
vet1 = Veterinary.create!(
  dni: '123456781',
  specialization: 'Cardiología',
  user_id: user6.id
)
vet2 = Veterinary.create!(
  dni: '123456782',
  specialization: 'General',
  user_id: user7.id
)

# Crear mascotas y asignarlas a usuarios normales
pets_data = [
  {
    name: 'Buddy',
    pet_type: 'Dog',
    breed: 'Labrador',
    birthday_date: '2018-03-25',
    gender: 'Male',
    weight: 30,
    height: 60,
    color: 'Black',
    user_id: user1.id
  },
  {
    name: 'Kitty',
    pet_type: 'Cat',
    breed: 'Siamese',
    birthday_date: '2019-05-14',
    gender: 'Female',
    weight: 10,
    height: 25,
    color: 'White',
    user_id: user2.id
  },
  {
    name: 'Max',
    pet_type: 'Dog',
    breed: 'Beagle',
    birthday_date: '2017-07-22',
    gender: 'Male',
    weight: 20,
    height: 40,
    color: 'Brown',
    user_id: user3.id
  }
]

# Guardar mascotas en la base de datos
pets_data.each do |pet_data|
  Pet.create!(pet_data)
end

# Crear vacunas, alérgenos y enfermedades
disease_names = ["Diabetes", "Artritis", "Infección respiratoria"]
vaccine_names = ["Rabia", "Moquillo", "Parvovirus"]
allergen_names = ["Polen", "Polvo", "Hierba"]

diseases = disease_names.map { |name| Disease.create!(name: name) }
vaccines = vaccine_names.map { |name| Vaccine.create!(name: name) }
allergens = allergen_names.map { |name| Allergen.create!(name: name) }

# Asignar condiciones, vacunaciones y alergias a las mascotas
pets = Pet.all
pets.each do |pet|
  # Condiciones de salud
  Condition.create!(
    diagnosis_date: Date.today - rand(1..5).months,
    comments: "Tratamiento necesario",
    pet: pet,
    disease: diseases.sample
  )

  # Vacunación
  Vaccination.create!(
    date: Date.today - rand(1..12).months,
    comments: "Aplicación sin problemas",
    pet: pet,
    vaccine: vaccines.sample
  )

  # Alergias
  Allergy.create!(
    detected_on: Date.today - rand(1..24).months,
    severity: ["Alta", "Moderada", "Baja"].sample,
    reactions: "Reacción alérgica leve",
    comments: "Monitorización continua",
    pet: pet,
    allergen: allergens.sample
  )
end

# Descripciones y datos de servicios para cada veterinario
services_data = [
  { name: "Consulta General", category: "Consulta", description: "Revisión general de salud", fee: 300.0 },
  { name: "Cirugía", category: "Procedimiento", description: "Cirugía menor", fee: 5000.0 },
  { name: "Vacunación", category: "Vacuna", description: "Aplicación de vacunas", fee: 200.0 }
]

veterinaries = [vet1, vet2]

veterinaries.each do |veterinary|
  services_data.each do |service_data|
    Service.create!(service_data.merge(veterinary: veterinary))
  end
end

# Crear citas (appointments) para las mascotas y asignarlas a servicios
appointment_reasons = ["Revisión", "Vacunación", "Tratamiento"]

pets.each do |pet|
  2.times do
    Appointment.create!(
      date: Date.today + rand(1..30).days,
      time: "#{rand(9..17)}:00",
      reason: appointment_reasons.sample,
      comments: "Paciente debe regresar para seguimiento",
      pet: pet,
      service: Service.all.sample,
      status: ["Agendada", "Completada"].sample
    )
  end
end

puts "Seeded #{User.count} users, #{Veterinary.count} veterinarians, #{Appointment.count} appointments, #{Service.count} services, #{Pet.count} pets, #{Condition.count} conditions, #{Vaccination.count} vaccinations, and #{Allergy.count} allergies."
