# person_spec.rb
require_relative 'person'
require 'rspec'

describe Person do
  let(:person) { Person.new(20, name: 'John Doe', parent_permission: true, id: 123) }

  context 'when creating a new person' do
    it 'should have the correct attributes' do
      expect(person.id).to eq(123)
      expect(person.name).to eq('John Doe')
      expect(person.age).to eq(20)
      expect(person.instance_variable_get(:@parent_permission)).to be(true)
      expect(person.rentals).to eq([])
    end
  end

  context 'when checking if a person can use services' do
    it 'should return true if of age' do
      allow(person).to receive(:of_age?).and_return(true)
      expect(person.can_use_services?).to eq(true)
    end

    it 'should return true if parent permission is granted' do
      allow(person).to receive(:of_age?).and_return(false)
      expect(person.can_use_services?).to eq(true)
    end
  end

  # context 'when converting person to hash' do
  #   it 'should have the correct hash structure' do
  #     hash = person.to_hash
  #     expect(hash['class']).to eq('Person')
  #     expect(hash['age']).to eq(20)
  #     expect(hash['name']).to eq('John Doe')
  #     expect(hash['parent_permission']).to eq(true)
  #     expect(hash['id']).to eq(123)
  #   end
  # end
end
