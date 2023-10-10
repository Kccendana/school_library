require_relative 'student'
require_relative 'teacher'

module PersonsModule
  def get_person(hash)
    if hash['class'] == 'Student'
      Student.new(hash['classroom'], hash['age'], name: hash['name'],
                                                  parent_permission: hash['parent_permission'],
                                                  id: hash['id'])
    else
      Teacher.new(hash['age'], hash['specialization'], name: hash['name'],
                                                       parent_permission: hash['parent_permission'],
                                                       id: hash['id'])
    end
  end
end
