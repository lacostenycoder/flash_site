namespace :admin do
  desc "creates admin"
  task :new => :environment do
    puts "Enter Admin details: "
    puts "enter first name:"
    first_name = STDIN.gets.chomp
    puts "enter last name:"
    last_name = STDIN.gets.chomp
    puts "enter email:"
    email = STDIN.gets.chomp
    puts "enter password:"
    password = STDIN.gets.chomp
    puts "enter password confirmation:"
    password_confirmation = STDIN.gets.chomp

    Admin.create!(first_name: first_name, last_name: last_name, email: email, password: password, password_confirmation: password_confirmation)
  end
end
