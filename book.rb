class Book
  attr_accessor :title, :author, :rentals

  def initialize(title, author)
    @title = title
    @author = author
    @rentals = []
  end

  def add_rental(_date, person)
    @rentals.push(Rental.new(self, person)) unless @rentals.include?(Rental.new(self, person))
  end
end
