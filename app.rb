require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('./lib/to_do')
require('pg')

DB = PG.connect({:dbname => 'to_do'})

get('/') do
  # @tasks = Task.all()
  erb(:index)
end

post('/list_name') do
   @list_name = params.fetch('name')
   erb(:list)
end

post('/list_form') do
  @tasks = []
  @tasks.push(params.fetch('item_1'))
  @tasks.push(params.fetch('item_2'))
  @name = params.fetch('name')
  erb(:success)
end


post('/tasks') do
  # description = params.fetch('description')
  # task = Task.new(description)
  # task.save()
  # erb(:success)
end
