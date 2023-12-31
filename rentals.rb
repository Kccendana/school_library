require_relative 'book'
require_relative 'person'
require_relative 'rental'
require_relative 'action_interface'
require_relative 'persons_module'

class Rentals < ActionInterface
  include PersonsModule
  def initialize()
    @rentals = read_rentals_from_json_file
    super()
  end

  def read_rentals_from_json_file()
    file_path = 'rentals.json'
    rentals = []

    begin
      # Read the JSON file
      json_data = File.read(file_path)

      # Parse the JSON data into an array of hashes
      rental_hashes = JSON.parse(json_data)

      # Create Book objects from each hash and add them to the array
      rental_hashes.each do |hash|
        book = Book.new(hash['book']['title'], hash['book']['author'])
        person = get_person(hash['person'])
        rental = Rental.new(hash['date'], book, person)
        rentals << rental
      end
    rescue StandardError => e
      puts "An error occurred: #{e.message}"
    end

    rentals
  end

  def create(books, people)
    if books.empty || people.empty
      puts 'Library is empty.'
    else
      puts 'Select the number of the book from the following list'
      books.list_all
      book_number = gets.chomp.to_i
      puts 'Select an ID from the following list'
      people.list_all
      person_id = gets.chomp.to_i
      person_to_rent = people.find { |person| person.id == person_id }
      puts 'Enter the date [yyyy-mm-dd]: '
      date = gets.chomp.to_s
      rent_person(date, books, book_number, person_to_rent, person_id)
    end
  end

  def rent_person(date, books, book_number, person_to_rent, person_id)
    if person_to_rent
      rental = Rental.new(date, books.find(book_number), person_to_rent)
      @rentals << rental
      save
      puts 'Book rented successfully.'
    else
      "Person with ID #{person_id} not found."
    end
  end

  def save
    rentals_hashes = @rentals.map(&:to_hash)
    rentals_json = JSON.pretty_generate(rentals_hashes)
    File.write('rentals.json', rentals_json)
  end

  def list_all
    if @rentals.empty?
      puts 'No rentals at the moment.'
    else
      puts 'To view rentals, enter your ID: '
      id = gets.chomp.to_i
      rental = @rentals.select { |rent| rent.person.id == id }

      if rental.empty?
        puts 'No record for that ID.'
      else
        puts 'Here is your record:'
        puts ''
        rental.each_with_index do |record, _index|
          puts "Date: #{record.date}, Book: #{record.book.title} by #{record.book.author}"
        end
      end
    end
  end

  def empty
    @rentals.empty?
  end
end
