require_relative 'book'
require_relative 'person'
require_relative 'action_interface'

class Books < ActionInterface
  def initialize(books)
    @books = books
    super()
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
      puts 'Book created successfully.'
    end
  end

  def find(&block)
    @books.find(&block)
  end
end
