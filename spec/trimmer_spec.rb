require_relative '../person'
require_relative '../capitalize_trimmer_decorator'

describe CapitalizeDecorator do
  context 'Create an instance of trimmer and test functionality'

  it 'should trim the first name' do
    person = Person.new(22, name: 'michaelscofield')
    capitalize_person = CapitalizeDecorator.new(person)
    trimmed_person = TrimmerDecorator.new(capitalize_person).correct_name
    expect(trimmed_person).to eq 'MICHAELSCO'
  end
end