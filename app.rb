require_relative 'book'
require_relative 'person'
require_relative 'rental'
require_relative 'student'
require_relative 'teacher'

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
    @books = []
    @rentals = []
    @people = []
  end

  def start
    loop { choose_option }
  end

  def book_lists
    if @books.empty?
      puts 'Book list is empty. Try again'
    else
      puts "There are #{@books.length} books in the list:"
      @books.each_with_index do |book, index|
        puts "#{index}) #{book.title} by #{book.author}"
      end
    end
  end

  def people_lists
    if @people.empty?
      puts 'People list is empty. Please try again and add people.'
    else
      @people.each_with_index do |person, index|
        puts "#{index}) [#{person.class}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
      end
    end
  end

  def create_person
    puts 'Please enter [1] to create a student or [2] to create a teacher. [Input the number]: '
    choice = gets.chomp
    puts 'Invalid choice. Please try again' unless %w[1 2].include?(choice)
    return unless %w[1 2].include?(choice)

    puts 'Name: '
    name = gets.chomp
    puts 'Age: '
    age = gets.chomp.to_i

    case choice
    when '1'
      create_student(name, age)
    when '2'
      create_teacher(name, age)
    end
  end

  def create_student(name, age)
    puts 'Grade: '
    grade = gets.chomp
    puts 'Parent permission? [Y/N]: '
    parent_permission = gets.chomp.downcase
    if parent_permission == 'y'
      parent_permission = true
    else
      false
    end

    if name.strip.empty? || age.to_s.strip.empty?
      puts 'You entered an empty name and age. Please try again'
    else
      student = Student.new(grade, age, name: name, parent_permission: parent_permission)
      @people << student
      puts "Student created successfully. ID is #{student.id}"
    end
  end

  def create_teacher(name, age)
    puts 'Specialization: '
    specialization = gets.chomp
    teacher = Teacher.new(age, specialization, name: name)
    @people << teacher
    puts "Teacher created successfully. ID is #{teacher.id}"
  end

  def create_book
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

  def create_rental
    if @books.empty? || @people.empty?
      puts 'Library is empty.'
    else
      puts 'Select the number of the book from the following list'
      book_lists
      book_number = gets.chomp.to_i
      puts 'Select an ID from the following list'
      people_lists
      person_id = gets.chomp.to_i

      person_to_rent = @people.find { |person| person.id == person_id }

      puts 'Enter the date [yyyy-mm-dd]: '
      date = gets.chomp.to_s

      if person_to_rent
        rental = Rental.new(date, @books[book_number], person_to_rent)
        @rentals << rental
        puts 'Book rented successfully.'
      else
        "Person with ID #{person_id} not found."
      end
    end
  end

  def list_all_rentals
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
