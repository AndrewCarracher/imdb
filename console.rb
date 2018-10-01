require('pg')
require_relative('./models/customers')
require_relative('./models/films')
require_relative('./models/tickets')
require('pry')

#
customer1 = Customer.new( 'name' => 'Brad', 'funds' => 30)
film1 = Film.new( 'title' => 'The Lion King', 'price' => 10)
ticket1 = Ticket.new('film_id' => film1.id, 'customers_id' => customer1.id)

p Customer.all()
# customer1.save()
# film1.save()
# # ticket1.save()
# p customer1.films_for_customer()
# binding.pry
# nil


# customer2 = Customer.new( 'name' => 'Mark', 'funds' => 50)
# customer2.save()
# customer3 = Customer.new( 'name' => 'Sue', 'funds' => 100)
# customer3.save()
# film1 = Film.new( 'title' => 'The Lion King', 'price' => 10)
# film1.save()
# film2 = Film.new( 'title' => 'Alladin', 'price' => 5)
# film2.save()
# film3 = Film.new( 'title' => 'The Little Mermaid', 'price' => 8)
# film3.save()
# ticket1 = Ticket.new('film_id' => film1.id, 'customers_id' => customer1.id)
# ticket1.save()
# ticket2 = Ticket.new('film_id' => film2.id, 'customers_id' => customer2.id)
# ticket2.save()
# ticket3 = Ticket.new('film_id' => film3.id, 'customers_id' => customer3.id)
# ticket3.save()

# p Customer.all()
# p Ticket.all()
# p Film.all()

# customer1.update()
# film2.update()
# ticket3.update()
