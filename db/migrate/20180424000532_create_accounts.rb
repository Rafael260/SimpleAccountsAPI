class CreateAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :accounts do |t|
      t.string :name
      t.references :person, foreign_key: true

      t.timestamps
    end
  end
end
