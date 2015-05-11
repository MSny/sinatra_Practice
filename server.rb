require "sinatra"
require "sqlite3"

db = SQLite3::Database.new "practice.db"

rows = db.execute <<-SQL
create table if not exists cars (
	id INTEGER PRIMARY KEY,
	class TEXT,
	company TEXT,
	year INTEGER
	);
SQL


get "/" do 
	erb :index , locals:{}
end