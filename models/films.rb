require_relative('../db/sql_runner')

class Film

  attr_accessor :title, :price
  attr_reader :id

  def initialize(options)
    @id     = options['id'].to_i()
    @title  = options["title"]
    @price  = options["price"].to_i()
  end

  def save()
    sql = "INSERT INTO films
    (
      title,
      price
    )
    VALUES
    (
      $1,
      $2
    )
      RETURNING id"

      values = [@title, @price]

      result = SqlRunner.run(sql, values)

      @id = result[0]['id'].to_i()
  end

  def self.all()
    sql = "SELECT * FROM films"

    order_hashes = SqlRunner.run(sql)

      order_objects = order_hashes.map do |order_hash|
        Film.new(order_hash)
      end
  end

  def update()
    sql = "
    UPDATE films
    SET title = $1, price = $2
    WHERE id = $3;
    "
    values = [@title, @price, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM films WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM films"
    SqlRunner.run(sql)
  end

  def customers_for_film()
    sql = " SELECT * FROM customers
    INNER JOIN tickets
    ON customers.id = tickets.customers_id
    WHERE films_id = $1;"

  movie_hash =   SqlRunner.run(sql, [@id])
  film = movie_hash.map do |order_hash|
    Film.new(order_hash)
  end
  return film
  end

  def number_of_customers()
    sql = " SELECT * FROM customers
    INNER JOIN tickets
    ON customers.id = tickets.customers_id
    WHERE films_id = $1;"

    movie_hash =   SqlRunner.run(sql, [@id])
    number_of_customers = 0
    for customer in movie_hash
      number_of_customers += 1
    end

    return number_of_customers
  end
end
