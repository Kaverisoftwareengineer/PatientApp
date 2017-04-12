json.extract! patient, :id, :firstname, :lastname, :phone_number, :address, :cost, :created_at, :updated_at
json.url patient_url(patient, format: :json)
