class AddInflectionalsIndex < ActiveRecord::Migration[5.2]
  def change
    add_index :inflectionals, :value
  end
end
