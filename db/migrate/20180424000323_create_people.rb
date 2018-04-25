class CreatePeople < ActiveRecord::Migration[5.1]
  def change
    create_table :people do |t|
      t.string :name
      t.string :reason
      t.string :cnpj

      t.timestamps
    end
  end
end
