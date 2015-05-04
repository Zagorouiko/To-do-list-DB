require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require("./lib/todo")
require("pg")

DB = PG.connect({:dbname => 'to_do_database'})

get("/") do
  @tasks = Todo.all()
  erb(:index)
end

post("/tasks") do
  description = params.fetch("description")
  task = Todo.new(description)
  task.save()
  erb(:success)
end

post("/clear") do
  Todo.clear()
  erb(:success)
end
