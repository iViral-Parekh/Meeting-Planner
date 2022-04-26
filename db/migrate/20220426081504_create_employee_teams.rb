class CreateEmployeeTeams < ActiveRecord::Migration[7.0]
  def change
    create_table :employee_teams do |t|
      t.references :team, index: true
      t.references :employee, index: {unique: true}

      t.timestamps
    end
  end
end
