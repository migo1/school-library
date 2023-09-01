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
  def create_person
    print 'Do you want to create a student (1) or a teacher(2)? [Input the number]:'
    input_result = gets.chomp

    print 'Age:'
    age = gets.chomp.to_i
    print 'Name:'
    name = gets.chomp

    case input_result
    when '1'
      print 'Has parent permission? [Y/N]: '
      permission = gets.chomp
      permission = true if %w[Y y].include?(permission)
      permission = false if %w[N n].include?(permission)

      @persons << Student.new(age, name, parent_permission: permission)
    when '2'
      print 'Specialization: '
      specialization = gets.chomp

      @persons << Teacher.new(age, specialization, name)

    end

    puts 'Person created successfully'
  end

  # list all person
  def list_persons
    @persons.each do |person|
      display_person(person)
    end
  end

  # create book
  def create_book
    print 'Title: '
    title = gets.chomp
    print 'Author: '
    author = gets.chomp

    @books << Book.new(title, author)
    puts 'Book created successfully'
  end

  # list all book
  def list_books
    @books.each do |book|
      display_books(book)
    end
  end

  def create_rental
    puts 'Select a book from the following list by number'
    @books.each_with_index do |book, index|
      print "#{index}) "
      display_books(book)
    end

    book_index = gets.chomp.to_i

    puts 'Select a person from the following list by number (not id)'
    @persons.each_with_index do |person, index|
      print "#{index}) "
      display_person(person)
    end

    person_index = gets.chomp.to_i

    print 'Date :'
    date = gets.chomp
    @rentals << Rental.new(date, @books[book_index], @persons[person_index])
    puts 'Rental created successfully'
  end

  def list_rentals_by_person
    print 'ID of person:'
    person_id = gets.chomp.to_i

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
