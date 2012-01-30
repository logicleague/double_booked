# Load Dependencies
require 'rubygems'
gem 'rails', '=2.3.8'
gem 'sqlite3-ruby'
require 'pp'
require 'test/unit'
require 'active_record'
require 'active_record/test_case'
require 'active_record/fixtures'
require 'active_support'
require 'active_support/core_ext'
require 'active_support/dependencies'
require 'active_support/test_case'
require 'active_support/inflector'

# Load the plugin
require 'accountable'

PLUGIN_DIR = File.expand_path(__FILE__ + '/../..')

# Setup the database
ActiveRecord::Base.logger = Logger.new "#{PLUGIN_DIR}/test/log/debug.log"
config = {'test' => {:adapter => 'sqlite3',
                     :database => "#{PLUGIN_DIR}/test/db/test.db"}}
ActiveRecord::Base.configurations = config
ActiveRecord::Base.establish_connection(config['test'])

# Load test schema
load "#{PLUGIN_DIR}/test/db/schema.rb"

MODEL_FILES = Dir["#{PLUGIN_DIR}/app/models/*"] +
              Dir["#{PLUGIN_DIR}/test/app/models/*"]

# Load test models
def load_models
  load_dependencies
  dependencies = %w(Account Entry Transaction)
  MODEL_FILES.each do |file|
    model = File.basename(file).gsub('.rb','').classify
    next if dependencies.include? model
    Object.class_eval {remove_const model if const_defined? model}
    $".reject! {|lib| lib == file}
    require file
  end
end

def load_dependencies
  dependencies = %w(Account Entry Transaction)
  MODEL_FILES.each do |file|
    model = File.basename(file).gsub('.rb','').classify
    next unless dependencies.include? model
    Object.class_eval {remove_const model if const_defined? model}
    $".reject! {|lib| lib == file}
    require file
  end
end

load_models

# Setup fixtures
class ActiveSupport::TestCase
  include ActiveRecord::TestFixtures
  self.fixture_path = "#{PLUGIN_DIR}/test/fixtures"
  self.use_instantiated_fixtures  = false
  self.use_transactional_fixtures = false
  fixtures :all
end

def create_fixtures(*table_names)
  valid_tables = Dir["#{PLUGIN_DIR}/test/fixtures/*"].collect do |f|
    File.basename(f, '.yml') if /.\.yml$/ =~ f
  end.compact
  if table_names.include? :all
    table_names = valid_tables
  else
    table_names.reject! { |t| !valid_tables.include? t.to_s }
  end
  Fixtures.reset_cache
  Fixtures.create_fixtures(ActiveSupport::TestCase.fixture_path,
                           table_names, {})
end
