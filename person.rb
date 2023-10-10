class Person
  attr_accessor :classroom
  attr_reader :id, :name, :age, :rentals

  def initialize(age, name: 'Unknown', parent_permission: true)
    @id = Random.rand(1..1000)
    @name = name
    @age = age
    @parent_permission = parent_permission
    @rentals = []
  end

  def can_use_services?
    of_age? || @parent_permission
  end

  def to_hash
    {"class" => self.class, "age" => @age, "name" => @name, "parent_permission" => @parent_permission, "id": @id}
  end

  private

  def of_age?
    @age >= 18
  end
end
