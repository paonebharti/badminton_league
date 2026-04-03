class CreatePlayers < ActiveRecord::Migration[8.1]
  def change
    create_table :players do |t|
      t.string :name, null: false
      t.integer :age, null: false
      t.string :email, null: false
      t.string :phone, null: false
      t.boolean :active, null: false, default: true

      t.timestamps
    end
  end
end
