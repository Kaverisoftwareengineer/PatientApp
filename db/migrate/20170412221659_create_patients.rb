class CreatePatients < ActiveRecord::Migration[5.0]
  def change
    create_table :patients do |t|
      t.string :firstname
      t.string :lastname
      t.string :phone_number
      t.string :address
      t.decimal :cost

      t.timestamps
    end
  end
end
