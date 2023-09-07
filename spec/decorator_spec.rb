require_relative 'spec_helper'

describe 'Decorator classes' do
  before :all do
    @person = Person.new(22, 'christopher')
    @trimmer = TrimmerDecorator.new(@person)
    @capital = CapitalizeDecorator.new(@person)
  end

  context 'decorator instances' do
    it 'should be an instance of TrimmerDecorator' do
      expect(@trimmer).to be_an_instance_of(TrimmerDecorator)
    end

    it 'should be an instance of CapitalizeDecorator' do
      expect(@capital).to be_an_instance_of(CapitalizeDecorator)
    end
  end

  context 'methods' do
    it 'return a trimmed string' do
      trimmed_string = @trimmer.correct_name
      expect(trimmed_string).to eq('christoph')
    end

    it 'return a capitalized string' do
      capitalized_string = @capital.correct_name
      expect(capitalized_string).to eq('Christopher')
    end
  end
end
