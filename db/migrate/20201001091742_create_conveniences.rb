class CreateConveniences < ActiveRecord::Migration[6.0]
  def change
    create_table :conveniences do |t|
      t.string :name

      t.timestamps
    end
  end
end
