require_relative('../db/sql_runner')

class Ticket

  attr_accessor :customer_funds
  attr_reader :id, :films_id, :customers_id, :ticket_price

  def initialize(options)
    @id              = options['id'].to_i()
    @films_id        = options["films_id"]
    @customers_id    = options["customers_id"]
  end

  def save()
    sql = "INSERT INTO tickets
    (
      films_id,
      customers_id
    )
    VALUES
    (
      $1,
      $2
    )
      RETURNING id"

      values = [@films_id, @customers_id]

      result = SqlRunner.run(sql, values)

      @id = result[0]['id'].to_i()
  end

  def self.all()
    sql = "SELECT * FROM tickets"

    order_hashes = SqlRunner.run(sql)

      order_objects = order_hashes.map do |order_hash|
        Ticket.new(order_hash)
      end
  end

  def update()
    sql = "
    UPDATE tickets
    SET films_id = $1, customers_id = $2
    WHERE id = $3;
    "
    values = [@films_id, @customers_id, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM tickets WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM tickets"
    SqlRunner.run(sql)
  end

end
