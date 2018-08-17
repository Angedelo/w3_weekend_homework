require_relative("../db/sql_runner")

class Ticket
  attr_reader :id
  attr_accessor :film_id, :customer_id

  def initialize(details)
    @id = details['id'].to_i if details['id']
    @film_id = details['film_id'].to_i
    @customer_id = details['customer_id'].to_i
  end

  def save
    sql = "INSERT INTO tickets
          (film_id, customer_id)
          values
          ($1, $2)
          RETURNING id"
    values = [@film_id, @customer_id]
    tickets = SqlRunner.run( sql,values ).first
    @id = tickets['id'].to_i
  end

  def update
    sql = "UPDATE tickets
          SET film_id = $1, customer_id = $2 WHERE id = $3"
    values = [@film_id, @customer_id, @id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM tickets"
    tickets = SqlRunner.run(sql)
    result = tickets.map { |ticket| Tickets.new( ticket ) }
    return result
  end

  def self.delete_all()
    sql = "DELETE FROM tickets"
    SqlRunner.run(sql)
  end

end
