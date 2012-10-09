class CreateFirstTables < ActiveRecord::Migration
  def change
    create_table :product_natures do |t|
      t.string :name, :null => false
      t.text :description
      t.string :payment_sequence
      t.integer :initial_quantity
      t.integer :current_quantity
    end

    create_table :products do |t|
      t.belongs_to :nature, :null => false
      t.string :name, :null => false
      t.text :description
      t.integer :arity
      t.decimal :amount, :precision => 16, :scale => 2
    end
    add_index :products, :nature_id

    create_table :sales do |t|
      t.belongs_to :product, :null => false
      t.string :number
      t.decimal :amount, :precision => 16, :scale => 2
      t.string :state
      t.string :error_code
      t.string :payment_sequence
      t.text :payment_infos
      t.text :log
    end
    add_index :sales, :product_id

    create_table :residents do |t|
      t.belongs_to :sale, :null => false
      t.string :last_name, :null => false
      t.string :first_name, :null => false
      t.date :birth_on
      t.string :club
      t.text :address
      t.string :phone
      t.string :email
      t.string :identity_number
      t.date :identity_valid_until
    end
    add_index :residents, :sale_id

  end
end
