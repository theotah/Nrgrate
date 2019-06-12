class AddPasswordUserDetails < ActiveRecord::Migration
  def change
    add_column :users, :company, :string
    add_column :users, :address, :string
    add_column :users, :contact, :decimal
    add_column :users, :Profession, :string
  end
end
