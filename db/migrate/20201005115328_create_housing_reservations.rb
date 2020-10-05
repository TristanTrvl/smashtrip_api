class CreateHousingReservations < ActiveRecord::Migration[6.0]
  def change
    create_table :housing_reservations do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :housing_advert, null: false, foreign_key: true
      t.datetime :start_date, null: false
      t.datetime :end_date, null: false
      t.integer :nb_persons, null: false, default:1
      t.string :status, null: false, default:'pending'

      t.timestamps
    end
  end
end
