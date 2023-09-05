require_relative 'book'
require_relative 'person'
require_relative 'teacher'
require_relative 'student'
require_relative 'rental'
require 'json'

class App
  def initialize
    @persons = load_people_from_json('local_db/people.json')
    @books = load_books_from_json('local_db/books.json')
    @rentals = []
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
