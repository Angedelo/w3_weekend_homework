require_relative('models/film')
require_relative('models/customer')
require_relative('models/ticket')

require('pry-byebug')

Ticket.delete_all()
Film.delete_all()
Customer.delete_all()

film1 = Film.new({
  'title' => 'Misson: Impossible - Fallout',
  'price' => 5
  })
film1.save

film2 = Film.new({
  'title' => 'Incredibles 2',
  'price' => 8
  })
film2.save

customer1 = Customer.new({
  'name' => 'Alice',
  'funds' => 10
  })
customer1.save

customer2 = Customer.new({
  'name'=> 'Tim',
  'funds' => 20
  })
customer2.save

ticket1 = Ticket.new({
  'film_id' => film1.id,
  'customer_id' => customer1.id
  })
ticket1.save

ticket2 = Ticket.new({
  'film_id' => film2.id,
  'customer_id' => customer1.id
  })
ticket2.save

ticket3 = Ticket.new({
  'film_id' => film1.id,
  'customer_id' => customer2.id
  })
ticket3.save


binding.pry
nil
