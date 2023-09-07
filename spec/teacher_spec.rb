require_relative 'spec_helper'

describe Teacher do
  before(:each) do
    @teacher = Teacher.new(35, 'Mathematics', 'Mr. Smith', parent_permission: true)
  end

  context 'attributes' do
    it 'has an age' do
      expect(@teacher.age).to eq(35)
    end

    it 'has a name' do
      expect(@teacher.name).to eq('Mr. Smith')
    end

    it 'has an empty rentals array by default' do
      expect(@teacher.rentals).to be_empty
    end
  end

  context 'methods' do
    it 'can use services' do
      expect(@teacher.can_use_services?).to be(true)
    end

    it 'returns JSON data' do
      expected_json = {
        'type' => 'Teacher',
        'id' => @teacher.id,
        'name' => 'Mr. Smith',
        'age' => 35,
        'specialization' => 'Mathematics',
        'parent_permission' => true,
        'rentals' => []
      }
      expect(@teacher.json_data).to eq(expected_json)
    end
  end
end
