require_relative 'app'
require_relative 'menu'

app = App.new
menu = Menu.new

def ask_user_type
  print 'Do you want to create a student (1) or a teacher (2)? [Input the number]: '
  gets.chomp
end

def ask_for_person_id
  print 'ID of person: '
  gets.chomp.to_i
end

def ask_book_info
  print 'Title: '
  title = gets.chomp
  print 'Author: '
  author = gets.chomp
  [title, author]
end

def ask_rental_info(app)
  puts 'Select a book from the following list by number'
  app.list_books.each_with_index do |book, index|
    print "#{index}) "
    app.display_books(book)
  end
  book_index = gets.chomp.to_i

  puts 'Select a person from the following list by number (not id)'
  app.list_persons.each_with_index do |person, index|
    print "#{index}) "
    app.display_person(person)
  end

  person_index = gets.chomp.to_i

  print 'Date: '
  date = gets.chomp

  [date, book_index, person_index]
end

puts "Welcome to School Library App! \n\n"

loop do
  menu.display_options

  case menu.user_option
  when '1'
    app.list_books
  when '2'
    app.list_persons
  when '3'
    user_type = ask_user_type
    app.create_person(user_type)
  when '4'
    book_info = ask_book_info
    app.create_book(*book_info)
  when '5'
    rental_info = ask_rental_info(app)
    app.create_rental(*rental_info)
  when '6'
    person_id = ask_for_person_id
    app.list_rentals_by_person(person_id)
  when '7'
    print 'Thank you for using this app!'
    break
  end

  puts "\n"
end
