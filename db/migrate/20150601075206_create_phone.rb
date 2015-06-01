class CreatePhone < ActiveRecord::Migration
  def change
    create_table :phones do |t|
      t.string :phone
      t.string :phone_type
      t.references :contact, index: true
    end
  end
end
