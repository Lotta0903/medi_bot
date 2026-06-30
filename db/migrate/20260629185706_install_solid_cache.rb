class InstallSolidCache < ActiveRecord::Migration[8.1]
  def change
    ActiveRecord::Schema[8.1].define(version: 0) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

end
  end
end
