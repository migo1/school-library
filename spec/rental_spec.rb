require_relative 'spec_helper'
require 'date'

describe Rental do
  before(:each) do
    @book = Book.new('The Great Gatsby', 'F. Scott Fitzgerald')
    @person = Person.new(25, 'John Doe', parent_permission: true)
    @date = Date.today
    @rental = Rental.new(@date, @book, @person)
  end

  context 'attributes' do
    it 'has a date' do
      expect(@rental.date).to eq(@date)
    end

    it 'has a book' do
      expect(@rental.book).to eq(@book)
    end

    it 'has a person' do
      expect(@rental.person).to eq(@person)
    end
  end

  context 'methods' do
    it 'correctly associates the rental with the book' do
      expect(@book.rentals).to include(@rental)
    end

    it 'correctly associates the rental with the person' do
      expect(@person.rentals).to include(@rental)
    end
  end
end
