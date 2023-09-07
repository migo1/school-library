require_relative 'spec_helper'

describe Classroom do
  before(:each) do
    @classroom = Classroom.new('Mathematics 101')
    @student = Student.new(16, 'Alice', parent_permission: true)
  end

  context 'attributes' do
    it 'has a label' do
      expect(@classroom.label).to eq('Mathematics 101')
    end

    it 'has an empty students array by default' do
      expect(@classroom.students).to be_empty
    end
  end

  context 'methods' do
    it 'can add a student to the classroom' do
      @classroom.add_student(@student)
      expect(@classroom.students).to include(@student)
      expect(@student.classroom).to eq(@classroom)
    end
  end
end
