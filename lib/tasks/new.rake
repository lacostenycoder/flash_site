namespace :admin do
  desc "creates admin-> rake admin:new"
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

    admin = Admin.new(first_name: first_name, last_name: last_name, email: email, password: password, password_confirmation: password_confirmation)

    if admin.save
        puts "Admin successfully created"
    else
        puts admin.errors.full_messages
    end
  end
end
