require_relative 'spec_helper'
require 'date'

describe Person do
  before(:each) do
    @person = Person.new(25, 'John Doe', parent_permission: true)
  end

  context 'attributes' do
    it 'has an age' do
      expect(@person.age).to eq(25)
    end

    it 'has a name' do
      expect(@person.name).to eq('John Doe')
    end

    it 'has an ID between 1 and 100' do
      expect(@person.id).to be_between(1, 100).inclusive
    end

    it 'has an empty rentals array by default' do
      expect(@person.rentals).to be_empty
    end
  end

  context 'method' do
    it 'can use services with parent permission' do
      expect(@person.can_use_services?).to be(true)
    end
  end

  describe '#add_rental' do
    it 'should add a rental to the person' do
      rental = Rental.new('2023-09-07', Book.new('new Book', 'new author'), @person)
      expect(@person.rentals).to include(rental)
    end
  end
end
