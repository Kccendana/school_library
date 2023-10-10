require_relative 'student'
require_relative 'teacher'
require_relative 'action_interface'
require_relative 'persons_module'

class Persons < ActionInterface
  include PersonsModule
  def initialize()
    @people = read_books_from_json_file
    super()
  end

  def read_books_from_json_file()
    file_path = 'persons.json'
    persons = []
    begin
      json_data = File.read(file_path)
      person_hashes = JSON.parse(json_data)
      person_hashes.each do |hash|
        person = get_person(hash)
        persons << person
      end
    rescue StandardError => e
      puts "An error occurred: #{e.message}"
    end
    persons
  end

  def list_all
    if @people.empty?
      puts 'People list is empty. Please try again and add people.'
    else
      @people.each_with_index do |person, index|
        puts "#{index}) [#{person.class}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
      end
    end
  end

  def create
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

  def save
    persons_hashes = @people.map(&:to_hash)
    persons_json = JSON.pretty_generate(persons_hashes)
    File.write('persons.json', persons_json)
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
      save
      puts "Student created successfully. ID is #{student.id}"
    end
  end

  def create_teacher(name, age)
    puts 'Specialization: '
    specialization = gets.chomp
    teacher = Teacher.new(age, specialization, name: name)
    @people << teacher
    save
    puts "Teacher created successfully. ID is #{teacher.id}"
  end

  def find(&block)
    @people.find(&block)
  end

  def empty
    @people.empty?
  end
end
