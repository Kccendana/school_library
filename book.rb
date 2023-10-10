require 'json'
class Book
  attr_accessor :title, :author, :rentals

  def initialize(title, author)
    @title = title
    @author = author
  end

  def save_book_to_file(title, author)
    book_json = {title: title, author: author}.to_json
    open('book.json', 'a') do | file |
      file.puts book_json
    end
  end
end
