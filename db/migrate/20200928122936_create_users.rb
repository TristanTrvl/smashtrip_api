class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :username
      t.string :password
      t.string :firstname
      t.string :name
      t.string :tel
      t.string :twitter
      t.string :discord

      t.timestamps
    end
  end
end
