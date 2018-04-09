class HistoricalValidateAddTo<%= table_name.camelize %> < ActiveRecord::Migration<%= migration_version %>
  def up
    change_table :<%= table_name %> do |t|
      t.json :password_histories
    end
  end
end
