require_relative 'book'
require_relative 'person'
require_relative 'action_interface'

class Books < ActionInterface
  def initialize()
    @books = read_books_from_json_file
    book_array.each do |book|
      puts "Title: #{book.title}, Author: #{book.author}"
    end
    super()
  end

  def read_books_from_json_file()
    file_path = 'books.json'
    books = []

    begin
      # Read the JSON file
      json_data = File.read(file_path)

      # Parse the JSON data into an array of hashes
      book_hashes = JSON.parse(json_data)

      # Create Book objects from each hash and add them to the array
      book_hashes.each do |hash|
        book = Book.new(hash['title'], hash['author'])
        books << book
      end
    rescue StandardError => e
      puts "An error occurred: #{e.message}"
    end

    books
  end

  def list_all
    if @books.empty?
      puts 'Book list is empty. Try again'
    else
      puts "There are #{@books.length} books in the list:"
      @books.each_with_index do |book, index|
        puts "#{index}) #{book.title} by #{book.author}"
      end
    end
  end

  def create
    puts 'Title: '
    title = gets.chomp
    puts 'Author: '
    author = gets.chomp

    if title.strip.empty? || author.strip.empty?
      puts 'Please enter the book title and author.'
    else
      book = Book.new(title, author)
      @books << book
      book.save_book_to_file(title, author)
      puts 'Book created successfully.'
    end
  end

  def find(&block)
    @books.find(&block)
  end

  def empty
    @books.empty?
  end
end
