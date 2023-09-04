require_relative 'book'
require_relative 'person'
require_relative 'teacher'
require_relative 'student'
require_relative 'rental'

class App
  def initialize
    @persons = []
    @books = []
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
    puts 'Student created successfully'
  end

  def create_teacher(age, name)
    print 'Specialization: '
    specialization = gets.chomp

    teacher = Teacher.new(age, specialization, name)
    @persons << teacher
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
end
