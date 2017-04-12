class AddDescriptionToPatients < ActiveRecord::Migration[5.0]
  def change
    add_column :patients, :description, :string
  end
end
