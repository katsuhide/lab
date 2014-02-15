class CreateFrients < ActiveRecord::Migration
  def change
    create_table :frients do |t|
      t.string :name
      t.string :address

      t.timestamps
    end
  end
end
