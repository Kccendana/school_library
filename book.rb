class Book
  attr_accessor :title, :author, :rentals

  def initialize(title, author)
    @title = title
    @author = author
  end

  def to_hash
    { "title" => @title, "author" => @author }
  end
end
