class CreateInflectionals < ActiveRecord::Migration[4.2]

  def self.up
    unless table_exists? :inflectionals
      create_table :inflectionals, :force => false do |t|
        t.timestamps
        t.integer "label_id"
        t.string "value", :limit => 4000
        t.string "normal_hash"
      end
    end

    unless index_exists?(:inflectionals, :label_id, :name => "ix_inflectionals_fk")
      add_index :inflectionals, :label_id, :name => "ix_inflectionals_fk"
    end
    unless index_exists?(:inflectionals, :normal_hash, :name => "ix_inflectionals_normal_hash")
      add_index :inflectionals, :normal_hash, :name => "ix_inflectionals_normal_hash"
    end
  end

  def self.down
    # we don't want to delete existing data
  end

end
