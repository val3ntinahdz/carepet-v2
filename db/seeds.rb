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

first_names = %i[Valentina Camila Diana Mariana María Lilian Ana]
last_names = %i[León Acevedo Pérez Gómez Orendain Padilla García]
addresses = [
  "123 Elm St, Springfield",
  "456 Maple Ave, Rivertown",
  "789 Oak Dr, Greenfield",
  "101 Pine Rd, Pleasantville",
  "202 Cedar St, Lakeview",
  "303 Birch Ave, Hillside",
  "404 Spruce Dr, Oceanview"
]

phone_numbers = [
  "951 579 8853",
  "951 579 2954",
  "951 579 2955",
  "951 579 2956",
  "951 579 2957",
  "951 579 2958",
  "951 579 2959"
]

disease_names = ["Diabetes", "Artritis", "Infección respiratoria"]
vaccine_names = ["Rabia", "Moquillo", "Parvovirus"]
allergen_names = ["Polen", "Polvo", "Hierba"]
services_data = [
  { name: "Consulta General", category: "Consulta", description: "Revisión general de salud", fee: 300.0 },
  { name: "Cirugía", category: "Procedimiento", description: "Cirugía menor", fee: 5000.0 },
  { name: "Vacunación", category: "Vacuna", description: "Aplicación de vacunas", fee: 200.0 }
]
appointment_reasons = ["Revisión", "Vacunación", "Tratamiento"]

# crear enfermedades, vacunas y alérgenos
diseases = disease_names.map { |name| Disease.create!(name: name) }
vaccines = vaccine_names.map { |name| Vaccine.create!(name: name) }
allergens = allergen_names.map { |name| Allergen.create!(name: name) }

users = []
first_names.each_with_index do |first_name, index|
  last_name = last_names[index]
  address = addresses.sample
  phone_number = phone_numbers[index]

  user = User.find_or_create_by!(
    first_name: first_name.to_s,
    last_name: last_name.to_s,
    email: "#{first_name.downcase}#{last_name.downcase}@gmail.com",
    address: address,
    phone_number: phone_number
  ) do |u|
    u.password = "password"  # Devise will encrypt this automatically
  end

  users << user
end

veterinarians = users.first(2).map.with_index(1) do |user, i|
  Veterinary.create!(
    dni: "12345678#{i}",
    specialization: i == 1 ? "Cardiología" : "General",
    user_id: user.id
  )
end

# Crear Servicios para cada Veterinario
services = veterinarians.flat_map do |veterinary|
  services_data.map do |service_data|
    Service.create!(service_data.merge(veterinary_id: veterinary.id))
  end
end

# Crear Mascotas para los Usuarios y asignar condiciones, vacunaciones y alergias
users.each do |user|
  pet = Pet.create!(
    name: ["Luna", "Rex", "Toby"].sample,
    pet_type: ["Perro", "Gato"].sample,
    breed: ["Golden Retriever", "Siames", "Bulldog"].sample,
    birthday_date: Date.today - rand(1..10).years,
    gender: ["Macho", "Hembra"].sample,
    color: ["Blanco", "Negro", "Café"].sample,
    weight: rand(5..30),
    height: rand(30..60),
    user_id: user.id
  )

  # Crear condición de salud vinculada a una enfermedad
  condition = Condition.create!(
    diagnosis_date: Date.today - rand(1..5).months,
    comments: "Tratamiento necesario",
    pet_id: pet.id,
    disease_id: diseases.sample.id
  )

  # Crear vacunación vinculada a una vacuna
  vaccination = Vaccination.create!(
    date: Date.today - rand(1..12).months,
    comments: "Aplicación sin problemas",
    pet_id: pet.id,
    vaccine_id: vaccines.sample.id
  )

  # Crear alergia vinculada a un alérgeno
  allergy = Allergy.create!(
    detected_on: Date.today - rand(1..24).months,
    severity: ["Alta", "Moderada", "Baja"].sample,
    reactions: "Reacción alérgica leve",
    comments: "Monitorización continua",
    pet_id: pet.id,
    allergen_id: allergens.sample.id
  )
end

# Crear citas (appointments) para cada mascota y asignarlas a servicios
users.each do |user|
  user.pets.each do |pet|
    2.times do
      Appointment.create!(
        date: Date.today + rand(1..30).days,
        time: "#{rand(9..17)}:00",
        reason: appointment_reasons.sample,
        comments: "Paciente debe regresar para seguimiento",
        pet_id: pet.id,
        service_id: services.sample.id,
        status: ["Agendada", "Completada"].sample
      )
    end
  end
end

puts "Seeded #{User.count} users, #{Veterinary.count} veterinarians, #{Appointment.count} appointments, #{Service.count} services, #{Pet.count} pets, #{Condition.count} conditions, #{Vaccination.count} vaccinations, and #{Allergy.count} allergies."
