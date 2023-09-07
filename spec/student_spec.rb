require_relative 'spec_helper'

describe Student do
  before(:each) do
    @student = Student.new(16, 'Alice', parent_permission: true)
    @classroom = Classroom.new('Mathematics 101')
  end

  context 'attributes' do
    it 'has an age' do
      expect(@student.age).to eq(16)
    end

    it 'has a name' do
      expect(@student.name).to eq('Alice')
    end

    it 'has an empty rentals array by default' do
      expect(@student.rentals).to be_empty
    end

    it 'has a classroom' do
      expect(@student.classroom).to be_nil
    end
  end

  context 'methods' do
    it 'can play hooky' do
      expect(@student.play_hooky).to eq('¯(ツ)/¯')
    end

    it 'can set a classroom' do
      @student.classroom = @classroom
      expect(@student.classroom).to eq(@classroom)
      expect(@classroom.students).to include(@student)
    end

    it 'returns JSON data' do
      expected_json = {
        'type' => 'Student',
        'id' => @student.id,
        'name' => 'Alice',
        'age' => 16,
        'parent_permission' => true,
        'rentals' => []
      }
      expect(@student.json_data).to eq(expected_json)
    end
  end
end
