class AddFkConstraintsIqvocInflectionals < ActiveRecord::Migration[4.2]
  def change
    add_foreign_key :inflectionals, :labels, column: 'label_id', on_update: :cascade, on_delete: :cascade
  end
end
