class AddOptInToEmployees < ActiveRecord::Migration[7.0]
  def change
    add_column :employees, :opt_in, :boolean
  end
end
