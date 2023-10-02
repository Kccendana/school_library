require_relative 'person'

class Teacher
  def initialize(id, age, specialization, name = 'Unknown')
    super(id, age, name)
    @specialization = specialization
  end

  def can_use_services?
    true
  end
end
