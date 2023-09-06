require_relative 'book'
require_relative 'person'
require_relative 'teacher'
require_relative 'student'
require_relative 'rental'
require 'json'

# App class
# rubocop:disable Metrics/ClassLength
class App
  attr_reader :books, :persons

  def initialize
    @persons = load_people_from_json('local_db/people.json')
    @books = load_books_from_json('local_db/books.json')
    @rentals = load_rentals_from_json('local_db/rentals.json')
  end

  # create person
  def create_person(user_type)
    print 'Age:'
    age = gets.chomp.to_i
    print 'Name:'
    name = gets.chomp

    case user_type
    when '1'
      create_student(age, name)
    when '2'
      create_teacher(age, name)
    else
      puts 'Invalid choice'
    end
  end

  def create_student(age, name)
    print 'Has parent permission? [Y/N]: '
    permission = gets.chomp
    permission = %w[Y y].include?(permission)

    student = Student.new(age, name, parent_permission: permission)
    @persons << student
    save_people_to_json('local_db/people.json')
    puts 'Student created successfully'
  end

  def create_teacher(age, name)
    print 'Specialization: '
    specialization = gets.chomp

    teacher = Teacher.new(age, specialization, name)
    @persons << teacher
    save_people_to_json('local_db/people.json')
    puts 'Teacher created successfully'
  end

  # list all person
  def list_persons
    @persons.each do |person|
      display_person(person)
    end
  end

  # create book
  def create_book(title, author)
    @books << Book.new(title, author)
    save_books_to_json('local_db/books.json')
    puts 'Book created successfully'
  end

  # list all book
  def list_books
    @books.each do |book|
      display_books(book)
    end
  end

  def create_rental(date, book_index, person_index)
    @rentals << Rental.new(date, @books[book_index], @persons[person_index])
    save_rentals_to_json('local_db/rentals.json')
    puts 'Rental created successfully'
  end

  def list_rentals_by_person(person_id)
    person = @persons.find { |p| p.id == person_id }
    rentals = @rentals.select { |r| r.person == person }
    puts 'Rentals'
    rentals.each do |r|
      puts "Date: #{r.date}, Book: \"#{r.book.title}\" by #{r.book.author}"
    end
  end

  def display_person(person)
    puts "[#{person.class.name}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
  end

  def display_books(book)
    puts "Title: \"#{book.title}\", Author: #{book.author}"
  end

  # Method to save books to a JSON file
  def save_books_to_json(filename)
    File.open(filename, 'w') do |file|
      json_data = @books.map(&:store_book)
      file.write(JSON.pretty_generate(json_data))
    end
  end

  def load_books_from_json(filename)
    return [] unless File.exist?(filename)

    json_data = JSON.parse(File.read(filename))
    json_data.map do |book_data|
      Book.new(book_data['title'], book_data['author'])
    end
  end

  def save_people_to_json(filename)
    File.open(filename, 'w') do |file|
      json_data = @persons.map(&:json_data)
      file.write(JSON.pretty_generate(json_data))
    end
  end

  def load_people_from_json(filename)
    return [] unless File.exist?(filename)

    json_data = JSON.parse(File.read(filename))

    json_data.map do |person_data|
      build_person_from_data(person_data)
    end.compact
  end

  def save_rentals_to_json(filename)
    rentals_data = @rentals.map do |rental|
      {
        date: rental.date,
        person_id: rental.person.id,
        book_title: rental.book.title
      }
    end

    File.open(filename, 'w') do |file|
      JSON.dump(rentals_data, file)
    end
  end

  def load_rentals_from_json(filename)
    if File.exist?(filename)
      file_content = File.read(filename)
      rentals_data = JSON.parse(file_content)

      # Convert the loaded rental data into Rental objects
      rentals_data.map do |data|
        date = data['date']
        person_id = data['person_id']
        book_title = data['book_title']
        person = find_person_by_id(person_id)
        book = find_book_by_title(book_title)
        Rental.new(date, book, person)
      end
    else
      []
    end
  rescue JSON::ParserError => e
    puts "Error parsing JSON file #{filename}: #{e.message}"
    []
  end

  def find_book_by_title(book_title)
    @books.find { |book| book.title == book_title }
  end

  def find_person_by_id(person_id)
    @persons.find { |person| person.id == person_id }
  end

  private

  def build_person_from_data(data)
    case data['type']
    when 'Teacher'
      build_teacher(data)
    when 'Student'
      build_student(data)
    end
  end

  def build_teacher(data)
    Teacher.new(
      data['age'],
      data['specialization'],
      data['name'],
      parent_permission: data['parent_permission']
    ).tap { |teacher| teacher.instance_variable_set(:@id, data['id']) }
  end

  def build_student(data)
    Student.new(
      data['age'],
      data['name'],
      parent_permission: data['parent_permission']
    ).tap { |student| student.instance_variable_set(:@id, data['id']) }
  end
end
# Convert the loaded rental data into Rental objects
# rubocop:enable Metrics/ClassLength
