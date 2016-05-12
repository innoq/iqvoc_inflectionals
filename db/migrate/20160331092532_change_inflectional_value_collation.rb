class ChangeInflectionalValueCollation < ActiveRecord::Migration
  def up
    if ActiveRecord::Base.connection.adapter_name == 'Mysql2'
      execute("ALTER TABLE inflectionals MODIFY value varchar(4000) CHARACTER SET utf8 COLLATE utf8_bin;")
    end
  end

  def down
    if ActiveRecord::Base.connection.adapter_name == 'Mysql2'
      execute("ALTER TABLE inflectionals MODIFY value varchar(4000) CHARACTER SET utf8 COLLATE utf8_general_ci;")
    end
  end
end
