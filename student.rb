require_relative 'person'
require_relative 'classroom'
require 'json'

class Student < Person
  attr_accessor :classroom

  def initialize(classroom, age, name: 'Unknown', parent_permission: true, id: 0)
    super(age, name: name, parent_permission: parent_permission, id: id)
    @classroom = classroom
  end

  def add_classroom(classroom)
    @classroom = classroom
    classroom.students.push(self) unless classroom.students.include?(self)
  end
end
