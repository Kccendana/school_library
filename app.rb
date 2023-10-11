require_relative 'books'
require_relative 'persons'
require_relative 'rentals'

class App
  OPTIONS = {
    '1' => :book_lists,
    '2' => :people_lists,
    '3' => :create_person,
    '4' => :create_book,
    '5' => :create_rental,
    '6' => :list_all_rentals,
    '7' => :exit_app
  }.freeze

  def initialize
    @books = Books.new
    @rentals = Rentals.new
    @people = Persons.new
  end

  def start
    loop { choose_option }
  end

  def book_lists
    @books.list_all
  end

  def people_lists
    @people.list_all
  end

  def create_person
    @people.create
  end

  def create_book
    @books.create
  end

  def create_rental
    @rentals.create(@books, @people)
  end

  def list_all_rentals
    @rentals.list_all
  end

  def choose_option
    puts 'Please choose an option by selecting a number:'
    OPTIONS.each { |key, value| puts "#{key}. #{value.to_s.tr('_', ' ')}" }

    option = gets.chomp

    if OPTIONS.include?(option)
      send(OPTIONS[option])
    else
      puts 'Invalid input. Try again.'
    end
  end

  def exit_app
    puts 'Thank you for using the app.'
    exit!
  end
end
