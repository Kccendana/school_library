# student_spec.rb
require_relative 'person'
require_relative 'classroom'
require_relative 'student'
require 'rspec'

describe Student do
  let(:classroom) { Classroom.new('Math') }
  let(:student) { Student.new(classroom, 18, name: 'Alice', parent_permission: true, id: 42) }

  context 'when creating a new student' do
    it 'should have the correct attributes' do
      expect(student.name).to eq('Alice')
      expect(student.age).to eq(18)
      expect(student.parent_permission).to eql(true)
      expect(student.id).to eq(42)
      expect(student.classroom.label).to eq('Math')
    end
  end

  context 'when adding a classroom' do
    it 'should update the classroom and add the student to the classroom' do
      new_classroom = Classroom.new('History')
      student.add_classroom(new_classroom)

      expect(student.classroom).to eq(new_classroom)
      expect(new_classroom.students).to include(student)
    end

    it 'should not add the student to the classroom if already present' do
      student.add_classroom(classroom)

      expect(student.classroom).to eq(classroom)
      expect(classroom.students.count(student)).to eq(1)
    end
  end

  context 'when converting a student to a hash' do
    it 'should have the correct hash structure' do
      hash = student.to_hash

      expect(hash['class']).to eq('Student')
      expect(hash['age']).to eq(18)
      expect(hash['name']).to eq('Alice')
      expect(hash['parent_permission']).to eq(true)
      expect(hash['id']).to eq(42)
      expect(hash['classroom']).to eq(classroom)
    end
  end
end
