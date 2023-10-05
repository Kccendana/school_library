require_relative 'book'
require_relative 'person'

class Rental
  attr_accessor :date, :book, :person

  def initialize(book, person)
    @date = Date.today
    @book = book
    @person = person

    book.add_rental(self)
    person.add_rental(self)
  end
end
