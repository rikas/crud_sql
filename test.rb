require_relative 'task'
require 'sqlite3'

DB = SQLite3::Database.new('tasks.db')
DB.results_as_hash = true

#####################
## READ One Task
#####################
# task = Task.find("2; DELETE FROM tasks;")
# puts "#{task.id} --> #{task.title} - #{task.description}"

#####################
## CREATE One Task
#####################
# task = Task.new(title: 'My task title', description: 'Description of the task')

# task = Task.new
# task.title = 'My title'
# task.description = 'Description'

# puts "#{task.id}) #{task.title} - #{task.description}"

# task.save

# puts "#{task.id}) #{task.title} - #{task.description}"

# puts task.id # The id of this new task, assigned automatically by SQLite
# puts "#{task.title} - #{task.description}"

# task = Task.find(1)
# puts "#{task.done.zero? ? "[ ]" : "[x]"} #{task.title}"

#####################
## UPDATE One Task
#####################
# task = Task.find(1)
# task.done = 1
# task.save

# task = Task.find(1)
# puts "#{task.done.zero? ? "[ ]" : "[x]"} #{task.title}"

#####################
# READ All Tasks
#####################
# tasks = Task.all

# tasks.each do |task|
#   puts "#{task.done.zero? ? "[ ]" : "[x]"} #{task.title}"
# end

# puts "Total: #{tasks.count} tasks"

#####################
# DELETE One Task
#####################
# puts Task.all.count
# task = Task.find(1)
# task.destroy
# puts Task.all.count
# puts Task.find(1).nil? # should be true
