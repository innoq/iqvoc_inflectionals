class AddFkConstraintsIqvocInflectionals < ActiveRecord::Migration
  def change
    add_foreign_key :inflectionals, :labels, column: 'label_id', on_update: :cascade, on_delete: :cascade
  end
end
