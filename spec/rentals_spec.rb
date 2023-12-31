require_relative '../rental'
require_relative '../person'
require_relative '../book'
require 'date'

describe Rental do
  describe '#initialize' do
    it 'creates a rental with the given date, person, and book' do
      book = Book.new('Clean Code', 'Robert C. Martin')
      person = Person.new(30, name: 'Robert C. Martin')
      rental = Rental.new(Date.today, book, person)
      expect(rental.date).to eq(Date.today)
      expect(rental.person).to eq(person)
      expect(rental.book).to eq(book)
    end
  end
end
