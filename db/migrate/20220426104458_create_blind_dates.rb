class CreateBlindDates < ActiveRecord::Migration[7.0]
  def change
    create_table :blind_dates do |t|
      t.datetime :meeting_date
      t.string :location
      t.text :groups, array: true, default: []
      t.references :leader

      t.timestamps
    end
  end
end
