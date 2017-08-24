require "./contact.rb"
require "yaml"
require "pp"
require "pry"

class CRM

  def initialize

  end

  def main_menu
    puts "\e[H\e[2J"
    while true
      print_main_menu
      user_command = gets.chomp.to_i
      call_option(user_command)
    end
  end

  def print_main_menu
    puts "\n-------- Select an option --------"
    puts '[1] Add a new contact'
    puts '[2] Display all the contacts'
    puts '[3] Search by ID or attribute'
    puts '[4] Modify an existing contact'
    puts '[5] Delete a contact'
    puts '[6] Exit'
    puts 'Enter a number: '
  end

  def call_option(command)
    case command
    when 1
      add_new_contact
    when 2
      display_all_contacts
    when 3
      search_by_attribute
    when 4
      modify_existing_contact
    when 5
      delete_contact
    when 6
      abort("Have a nice day!")
    else
      puts "\e[H\e[2J"
      puts "You didn't choose a valid option!"
    end
  end

  def add_new_contact
    puts "New contact first name:"
    first_name = gets.chomp.to_s.downcase

    puts "New contact last name:"
    last_name = gets.chomp.to_s.downcase

    puts "New contact email address:"
    email = gets.chomp.to_s.downcase

    puts "Notes: (just hit enter if no notes)"
    note = gets.chomp.to_s.downcase

    new_contact = {
    first_name:  first_name,
    last_name:   last_name,
    email:       email,
    note:        note
    }
    Contact.create(new_contact)

  end

  def display_all_contacts
    puts "\e[H\e[2J"
    puts "-------- Contact List: --------"
    # display = []
    # Contact.all.each {|each_contact| display << each_contact.to_yaml}
    # display.each  {|each| each[0..24] = "\n"}
    #
    # puts display
    Contact.all.each {|each_contact| pp each_contact}
  end

  def get_id(func)

    while true
      begin
        puts "\nWhat's the ID of the contact to #{func}? \n(Or hit enter again to view a list. Press x to exit to main menu.)"


        id = gets.chomp

        case id
        when "x"
          main_menu
          redo
        when ""
          display_all_contacts
          redo
        else
          contact_to_modify = Contact.find(id.to_i)
        end




      rescue
        puts "No contact with this ID!"

      else
        return contact_to_modify
      end
    end
  end

  def modify_existing_contact
    puts "\e[H\e[2J"
    puts "-------- Modifying a contact --------"

    contact_to_modify = get_id("modify")

    pp contact_to_modify

        puts "\nWhat is the attribute to be modified? Options are:"
        puts "[1] First name"
        puts "[2] Last name"
        puts "[3] Email address"
        which_attr = gets.chomp.to_s

        case which_attr
        when "1"
          puts "\nThe contact's first name is currently #{contact_to_modify.first_name}. What would you like to change it to?"
          newval = gets.chomp.to_s.downcase
          contact_to_modify.update({first_name: newval})
          contact_to_modify.save

        when "2"
          puts "\nThe contact's last name is currently #{contact_to_modify.last_name}. What would you like to change it to?"
          newval = gets.chomp.to_s.downcase
          contact_to_modify.update({last_name: newval})
          contact_to_modify.save

        when "3"
          puts "\nThe contact's email is currently #{contact_to_modify.email}. What would you like to change it to?"
          newval = gets.chomp.to_s.downcase
          contact_to_modify.update({email: newval})
          contact_to_modify.save

        else
          puts "Invalid attribute given!"
          return
        end

  end

  def delete_contact
    puts "\e[H\e[2J"
    puts "-------- Deleting a contact --------"
    puts "---------------------\nWarning! Deleting a contact cannot be undone!"
    id = get_id("delete")[:id]

    if Contact.find(id)
      Contact.find(id).delete
    else
      puts "No contact with this ID."
    end

  end

  def search_by_attribute
    begin
      puts "\e[H\e[2J"
      puts "-------- Searching by ID or attribute --------"
      while true
        puts "\nWhat is the attribute to be search by? Enter a number:"
        puts "[1] ID"
        puts "[2] First name"
        puts "[3] Last name"
        puts "[4] Email address"
        puts "Or hit 'x' to return to main menu."
        which_attr = gets.chomp.to_s

        case which_attr
        when "x"
          main_menu
        when "1"
          puts "What ID do you want to search for?"
          val = gets.chomp.to_i
          pp Contact.find(val)
        when "2"
          puts "What first name do you want to search for?"
          val = gets.chomp.to_s.downcase
          pp Contact.find_by({first_name: val})
        when "3"
          puts "What last name do you want to search for?"
          val = gets.chomp.to_s.downcase
          pp Contact.find_by({last_name: val})
        when "4"
          puts "What email do you want to search for?"
          val = gets.chomp.to_s.downcase
          pp Contact.find_by({email: val})
        else
          puts "Invalid input!"
          redo
        end
      end
    rescue
      puts "Invalid input!"
    end
  end
end

CRM.new.main_menu

at_exit do
  ActiveRecord::Base.connection.close
end
