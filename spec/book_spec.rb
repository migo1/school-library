require_relative 'spec_helper'

describe Book do
  before(:each) do
    @book = Book.new('The Great Gatsby', 'F. Scott Fitzgerald')
  end

  context 'attributes' do
    it 'has a title' do
      expect(@book.title).to eq('The Great Gatsby')
    end

    it 'has an author' do
      expect(@book.author).to eq('F. Scott Fitzgerald')
    end
  end

  describe '#add_rental' do
    it 'should return empty array' do
      expect(@book.rentals).to be_empty
    end
  end
end
