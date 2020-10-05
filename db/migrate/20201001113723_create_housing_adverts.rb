class CreateHousingAdverts < ActiveRecord::Migration[6.0]
  def change
    create_table :housing_adverts do |t|
      t.datetime :start_date, null: false
      t.datetime :end_date, null: false
      t.integer :event_id, null: false
      t.integer :price
      t.text :desc
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
