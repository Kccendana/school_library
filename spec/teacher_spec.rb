# student_spec.rb
require_relative '../person'
require_relative '../classroom'
require_relative '../teacher'
require 'rspec'

describe Teacher do
  let(:teacher) { Teacher.new(18, 'bacteria', name: 'Alice', parent_permission: true, id: 43) }

  context 'when creating a new teacher' do
    it 'should have the correct attributes' do
      expect(teacher.name).to eq('Alice')
      expect(teacher.age).to eq(18)
      expect(teacher.parent_permission).to eq(true)
      expect(teacher.id).to eq(43)
      expect(teacher.specialization).to eq('bacteria')
    end
  end

  context 'when converting a teacher to a hash' do
    it 'should have the correct hash structure' do
      hash = teacher.to_hash

      expect(hash['class']).to eq(Teacher)
      expect(hash['age']).to eq(18)
      expect(hash['name']).to eq('Alice')
      expect(hash['parent_permission']).to eq(true)
      expect(hash['id']).to eq(43)
      expect(hash['specialization']).to eq('bacteria')
    end
  end
end
