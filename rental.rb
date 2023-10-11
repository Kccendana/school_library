require_relative 'book'
require_relative 'person'
require 'json'

class Rental
  attr_accessor :date, :book, :person

  def initialize(date, book, person)
    @date = date
    @book = book
    @person = person
  end

  def to_hash
    {
      'date' => @date,
      'book' => @book.to_hash,
      'person' => @person.to_hash
    }
  end
end
