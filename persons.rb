require_relative 'student'
require_relative 'teacher'
require_relative 'action_interface'

class Persons < ActionInterface
  def initialize(people)
    @people = people
    super()
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
end
