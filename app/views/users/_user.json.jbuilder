json.extract! user, :id, :email, :password, :role_id, :name, :fname, :mname, :dob, :phn, :address, :teacher_id, :created_at, :updated_at
json.url user_url(user, format: :json)
