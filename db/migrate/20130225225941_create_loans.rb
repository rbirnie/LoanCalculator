class CreateLoans < ActiveRecord::Migration
  def change
    create_table :loans do |t|
      t.decimal :term
      t.decimal :amount
      t.integer :zip
      t.decimal :rate
      t.decimal :down
      t.decimal :appriciation
      t.decimal :fees
      t.decimal :ins

      t.timestamps
    end
  end
end
