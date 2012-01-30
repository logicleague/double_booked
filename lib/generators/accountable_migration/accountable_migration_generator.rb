class AccountableMigrationGenerator < Rails::Generator::Base
  def manifest
    record do |m|
      m.migration_template 'accountable.rb.erb', File.join('db', 'migrate'),
                           :migration_file_name => "create_accountable_models"
    end
  end
end
