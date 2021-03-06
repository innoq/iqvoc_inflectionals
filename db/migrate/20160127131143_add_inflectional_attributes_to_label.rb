class AddInflectionalAttributesToLabel < ActiveRecord::Migration[4.2]
  def change
    add_column :labels, :base_form, :string  unless column_exists?(:labels, :base_form)
    add_column :labels, :inflectional_code, :string unless column_exists?(:labels, :inflectional_code)
  end
end
