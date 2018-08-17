require_relative("../db/sql_runner")

class Customer

attr_reader :id
attr_accessor :name, :funds

def initialize(details)
  @id = details['id'].to_i if details['id']
  @name = details['name']
  @funds = details['funds']
end

def save
  sql = "INSERT INTO customers
        (name, funds)
        VALUES
        ($1, $2)
        RETURNING id"
  values = [@name, @funds]
  customer = SqlRunner.run(sql, values).first
  @id = customer['id'].to_i
end

def update
  sql = "UPDATE customers
        SET name = $1, funds = $2 WHERE id = $3"
  values = [@name, @funds, @id]
  SqlRunner.run(sql, values)
end

def films
  sql = "SELECT films.* FROM films
        INNER JOIN tickets
        ON films.id = tickets.film_id
        WHERE customer_id = $1"
end

def self.all()
  sql = "SELECT * FROM customers"
  values = []
  customers = SqlRunner.run(sql, values)
  return self.map_items(customers)
end

def self.map_items(customer_data)
  result = customer_data.map { |customer| Customer.new( customer ) }
  return result
end

def self.delete_all()
  sql = "DELETE FROM customers"
  values = []
  SqlRunner.run(sql, values)
end



end
