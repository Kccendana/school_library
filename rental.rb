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

  def save_rental_to_file(date, book, person)
    rental_json = {date: date, book: book, person: person}.to_json
    open('rental.json', 'a') do | file |
      file.puts rental_json
    end
  end

end
