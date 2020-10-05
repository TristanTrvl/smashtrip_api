class CreateHousingAdverts < ActiveRecord::Migration[6.0]
  def change
    create_table :housing_adverts do |t|
      t.datetime :start_date
      t.datetime :end_date
      t.integer :event_id
      t.integer :price
      t.text :desc
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
