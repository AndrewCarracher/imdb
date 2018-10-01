require_relative('../db/sql_runner.rb')

class Customer

  attr_accessor :name, :funds
  attr_reader :id

  def initialize(options)
    @id     = options['id'].to_i()
    @name   = options['name']
    @funds  = options['funds'].to_i()
  end

  def buy_tickets(ticket_price)
    new_funds = @funds - ticket_price
    if new_funds < 0
      return "Sorry not enough funds"
    else
      sql = "
      UPDATE customers
      SET funds = $1
      WHERE id = $2"
      values =  [new_funds, @custors_id]
      SqlRunner.run(sql, values)
    end
  end

  def save()
    sql = "INSERT INTO customers
    (
      name,
      funds
    )
    VALUES
    (
      $1,
      $2
    )
      RETURNING id"

      values = [@name, @funds]

      result = SqlRunner.run(sql, values)

      @id = result[0]['id'].to_i()
  end

  def self.all()
    sql = "SELECT * FROM customers"

    order_hashes = SqlRunner.run(sql)

      order_objects = order_hashes.map do |order_hash|
        Customer.new(order_hash)
      end
  end

  def update()
    sql = "
    UPDATE customers
    SET name = $1, funds = $2
    WHERE id = $3;
    "
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM customers WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end

  def films_for_customer()
    sql = " SELECT * FROM films
    INNER JOIN tickets
    ON films.id = tickets.films_id
    WHERE customers_id = $1;"

    customer_hash =   SqlRunner.run(sql, [@id])
    customer = customer_hash.map do |order_hash|
      Customer.new(order_hash)
    end
  return customer
  end

  def customers_number_of_tickets()
    sql = " SELECT * FROM films
    INNER JOIN tickets
    ON films.id = tickets.films_id
    WHERE customers_id = $1;"

    number_of_tickets = 0
    customer_hash =   SqlRunner.run(sql, [@id])
    for customer in customer_hash
      number_of_tickets += 1
    end

    return number_of_tickets
  end

end
