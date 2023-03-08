require 'active_record'
require '../config/globals'

db_config = YAML.load_file("#{ROOT_PATH}/database.yaml")
ActiveRecord::Base.establish_connection(db_config['development'])
