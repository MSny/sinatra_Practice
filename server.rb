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
  cars = db.execute("SELECT * FROM cars");
	erb :index , locals:{cars: cars}
end

post "/cars" do
  db.execute("INSERT INTO cars (class,company,year) VALUES (?,?,?);",params[:class],params[:company],params[:year])
  redirect('/')
end