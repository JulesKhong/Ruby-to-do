require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('./lib/to_do')
require('pg')
require('pry')

DB = PG.connect({:dbname => 'to_do'})

get('/') do
  @lists = List.all()
  erb(:index)
end

# get('/lists/new') do
#   erb(:list_form)
# end
#
# get('/lists') do
#   erb(:list_form)
# end

post('/lists') do
   @list_name = params.fetch('name')
   @new_list = List.new({:name => @list_name, :id => nil})
   @new_list.save()
   erb(:list)
end

get('/list_form') do
  erb(:index)
end

post('/list_form') do
  @tasks = []
  @task = params.fetch('item_1')
  @tasks.push(@task)
  @deadline = params.fetch('due_1')
  # @name = params.fetch('name')
  @new_list_id = (params.fetch('name')).to_i()
  @new_task = Task.new({:description => @task, :list_id => @new_list_id, :due_date => @deadline})
  @new_task.save()
  erb(:success)
end


post('/tasks') do
  description = params.fetch('description')
  due_date = params.fetch('due_1')
  list_id = params.fetch("list_id").to_i()
  @list = List.find(list_id)
  @task = Task.new({:description => description, :list_id => list_id, :due_date => due_date})
  @task.save()
  erb(:success)
end

get("/lists/:id") do
  @list = List.find(params.fetch("id").to_i())
  erb(:list)
end
