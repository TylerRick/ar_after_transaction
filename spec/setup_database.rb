ActiveRecord::Base.establish_connection(
  :adapter => "mysql", # need something that has transactions...
  :database => "ar_after_transaction"
)

ActiveRecord::Base.connection.execute('drop table if exists users')
ActiveRecord::Base.connection.execute('drop table if exists log_entries')
ActiveRecord::Schema.define(:version => 1) do
  create_table :users do |t|
    t.string :name
    t.timestamps
  end

  create_table :log_entries do |t|
    t.belongs_to :user
    t.string :logged_changes
    t.timestamps
  end
end

#require 'logger'
#ActiveRecord::Base.logger = Logger.new(STDOUT)

class User < ActiveRecord::Base
end
class LogEntry < ActiveRecord::Base
  serialize :logged_changes
end
