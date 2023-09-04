require_relative 'app'
require_relative 'menu'

app = App.new
menu = Menu.new

puts "Welcome to School Library App! \n\n"

loop do
  menu.display_options

  case menu.user_option
  when '1'
    app.list_books
  when '2'
    app.list_persons
  when '3'
    app.create_person
  when '4'
    app.create_book
  when '5'
    app.create_rental
  when '6'
    app.list_rentals_by_person
  when '7'
    print 'Thank you for using this app!'
    break
  end

  puts "\n"
end
