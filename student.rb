require_relative 'person'
require_relative 'classroom'
require 'json'

class Student < Person
  attr_accessor :classroom

  def initialize(classroom, age, name: 'Unknown', parent_permission: true)
    super(age, name: name, parent_permission: parent_permission)
    @classroom = classroom
  end

  def play_hooky
    '¯(ツ)/¯'
  end

  def save_student_to_file(classroom, age, name, parent_permission)
    student_json = {classroom: classroom, age: age, name: name, parent_permission: parent_permission}.to_json
    open('students.json', 'a') do | file |
      file.puts student_json
    end
  end

  def add_classroom(classroom)
    @classroom = classroom
    classroom.students.push(self) unless classroom.students.include?(self)
  end
end
