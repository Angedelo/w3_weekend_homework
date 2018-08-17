require_relative("../db/sql_runner")

class Film

attr_reader :id
attr_accessor :title, :price

def initialize(details)
  @id = details['id'].to_i if details['id']
  @title = details['title']
  @price = details['price']
end

def save
  sql = "INSERT INTO films
        (title, price)
        VALUES
        ($1, $2)
        RETURNING id"
  values = [@title, @price]
  film = SqlRunner.run(sql, values).first
  @id = film['id'].to_i
end

def update
  sql = "UPDATE films
        SET title = $1, price = $2 WHERE id = $3"
  values = [@title, @price, @id]
  SqlRunner.run(sql, values)
end

def customers()
  sql = "SELECT customers.*
  FROM customers
  INNER JOIN tickets
  ON customers.id = tickets.customer_id
  WHERE film_id = $1"
  values = [@id]
  customer_data = SqlRunner.run(sql, values)
  return Customer.map_items(customer_data)
end

def self.all()
  sql = "SELECT * FROM films"
  values = []
  films = SqlRunner.run(sql, values)
  return self.map_items(films)
end

def self.map_items(film_data)
  result = film_data.map { |film| Film.new( film ) }
  return result
end

def self.delete_all()
  sql = "DELETE FROM films"
  values = []
  SqlRunner.run(sql, values)
end





end
