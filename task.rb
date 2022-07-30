class Task
  attr_reader :id
  attr_accessor :title, :description, :done

  def initialize(attributes = {})
    # Converts the keys of the attributes hash, from strings to symbols, because we are reading the
    # values using symbols.
    attributes.transform_keys! { |key| key.to_sym }

    @id = attributes[:id]
    @title = attributes[:title]
    @description = attributes[:description]
    @done = attributes[:done] || 0 # 0 - false // 1 - true
  end

  # Creates or updates the record in the DB, depending on the presence of @id. The @id instance
  # variable will only be assigned when reading the id from the database so instances that have @id
  # are already persisted in the DB.
  def save
    @id.nil? ? create_record : update_record
  end

  def destroy
    query = "DELETE FROM tasks WHERE id = ?"

    DB.execute(query, @id)
  end

  def self.all
    query = 'SELECT * FROM tasks'

    result = DB.execute(query)

    # Returns an array of Task instances
    result.map { |result| new(result) }
  end

  def self.find(id)
    # Vulnerable to SQL Injections!
    # query = "SELECT * FROM tasks WHERE id = #{id}"

    query = 'SELECT * FROM tasks WHERE id = ?'

    # [{"id"=>1, "title"=>"Complete Livecode", "description"=>"Implement CRUD on Task", "done"=>0}]
    result = DB.execute(query, id)

    # Return nil right away if the result array is empty! (The id provided is NOT in my DB)
    return nil if result.empty?

    # {"id"=>1, "title"=>"Complete Livecode", "description"=>"Implement CRUD on Task", "done"=>0}
    details = result.first

    Task.new(details)
  end

  private

  def create_record
    query = 'INSERT INTO tasks (title, description, done) VALUES (?, ?, ?)'

    DB.execute(query, @title, @description, @done)

    @id = DB.last_insert_row_id
  end

  def update_record
    query = 'UPDATE tasks SET title = ?, description = ?, done = ? WHERE id = ?'

    DB.execute(query, @title, @description, @done, @id)
  end
end
