gem 'activerecord', '=4.2.9'
require 'active_record'
require 'mini_record'

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'crm.sqlite3')

class Contact < ActiveRecord::Base

  field :first_name, as: :string
  field :last_name,  as: :string
  field :email,      as: :string
  field :note,       as: :text

  def full_name
    "#{ first_name } #{ last_name }"
  end


  # @@contacts = []
  # @@id = 1
  #
  # attr_reader :id
  # attr_accessor :first_name, :last_name,  :email, :notes

  # def initialize(first_name, last_name, email, note="N/A")
  #   @first_name = first_name
  #   @last_name  = last_name
  #   @email      = email
  #   @notes      = note
  #   @id         = @@id
  #   @@id += 1
  # end

  # def self.create(first_name,last_name,email,note="N/A")
  #   new_contact = Contact.new(first_name,last_name,email,note)
  #   @@contacts << new_contact
  #   return new_contact
  # end
  #
  # def self.all
  #   @@contacts
  # end
  #
  # def self.find(this_id)
  #   first_result = @@contacts.select { |each_contact| each_contact.id == this_id}[0]
  #   return first_result
  # end
  #
  #
  # def update(which_attr, new_value)
  #   #converts attribute given to "which_attr=", eg from "email" to "email=". then uses .send method to apply it to Self object, with new_value as its parameter. So x.update("a","b") turns into x.a=(b)
  #   which = which_attr+"="
  #   self.send(which, new_value)
  # end
  #
  # def self.find_by(searchby,searchfor)
  #   # searchby is a method to be applied to each element of the @@contacts array; it's applied with the .send method.
  #   # select outputs an array of values (in this case, as we iterate through @@contacts, an array of Contact objects) for which the given condition is true. the given condition is each_contact.searchby == searchfor
  #   begin
  #     contact = @@contacts.select { |each_contact| (each_contact.send(searchby)).downcase == searchfor.to_s.downcase}[0]
  #
  #     if contact == nil
  #       puts "There is no contact with #{searchby} = '#{searchfor}'!"
  #     end
  #
  #   rescue
  #     puts "Please enter a valid attribute!"
  #     return
  #   else
  #     return contact
  #   end
  #
  # end
  #
  # def self.delete_all
  #   @@contacts = []
  # end

  #
  # def delete
  #   begin
  #     @@contacts.delete(self)
  #   rescue
  #     "#{self} isn't in this list."
  #   else
  #     return
  #   end
  # end

end

Contact.auto_upgrade!


# andy = Contact.create("Andy", "Tran", "andy8tran@gmail.com")
# john = Contact.create("John", "Roberts", "john@gmail.com")
#
# #
# # puts Contact.find_by("email","andy8tran@gmail.com").first_name
# #
# # #
# # p andy.update("email","www.wikipedia.com")
# p Contact.all
# Contact.delete_all
# puts
# puts "deleting all"
# puts
# p Contact.all
#
# puts andy.full_name
# # andy.delete
# #
# # p Contact.all
