require_relative 'person'
require 'json'

class Teacher < Person
  def initialize(age, specialization, name: 'Unknown', parent_permission: true)
    super(age, name: name, parent_permission: parent_permission)
    @specialization = specialization
  end

  def can_use_services?
    true
  end

  def save_teacher_to_file(age, specialization, name)
    teacher_json = {age: age, specialization: specialization, name: name}.to_json
    open('teachers.json', 'a') do | file |
      file.puts teacher_json
    end
  end
end
