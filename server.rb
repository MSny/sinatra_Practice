require "sinatra"
require "sqlite3"
require "json"

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

get "/cars/:id" do
	car = db.execute("SELECT * FROM cars WHERE id=?", params[:id])
	erb :show, locals:{car: car[0]}
end

post "/cars" do
  db.execute("INSERT INTO cars (class,company,year) VALUES (?,?,?);",params[:class],params[:company],params[:year])
  redirect('/')
end

put "/cars/:id" do
	db.execute("UPDATE cars SET class = ?, company = ?, year = ? WHERE id= ?", params[:class],params[:company],params[:year], params[:id])
	redirect("cars/#{params[:id]}")
end

delete "/cars/:id" do
  db.execute("DELETE FROM cars WHERE id = ?", params[:id])
  redirect("/")
end

get "/api/cars" do
  cars = db.execute("SELECT * FROM cars")
  content_type :json
  cars.to_json
end

get "/api/cars/:id" do
	cars = db.execute("SELECT * FROM cars WHERE id = ?", params[:id])
	content_type :json
	cars.to_json
end