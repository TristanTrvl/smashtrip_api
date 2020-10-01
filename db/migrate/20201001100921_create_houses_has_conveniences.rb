class CreateHousesHasConveniences < ActiveRecord::Migration[6.0]
  def change
    create_table :houses_has_conveniences do |t|
      t.belongs_to :house, null: false, foreign_key: true
      t.belongs_to :convenience, null: false, foreign_key: true

      t.timestamps
    end
  end
end
