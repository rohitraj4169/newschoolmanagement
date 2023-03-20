class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.references :role, null: false, foreign_key: true
      t.string :name
      t.string :fname
      t.string :mname
      t.date :dob
      t.string :phn
      t.text :address
      t.integer :teacher_id

      t.timestamps
    end
  end
end
