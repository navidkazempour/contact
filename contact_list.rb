require_relative 'contact'

# Interfaces between a user and their contact list. Reads from and writes to standard I/O.
class ContactList

  def prompt
    puts "Here is a list of available commands:"
    puts "\tnew\t- Create a new contact"
    puts "\tlist\t- List all contacts"
    puts "\tshow\t- Show a contact"
    puts "\tsearch\t- Search contacts"
    case ARGV[0] 
    when "new"
      new
      # should take name and email from user
      # then call Contact.create(name, email)
    when "list"
      # puts Contact.all
      print_contacts(Contact.all)
    end 
  end

  def new
    puts "Name and email please:"
    name = ARGV[1]
    email = ARGV[2]
    Contact.create(name,email)
  end

  def print_contacts(contacts)
    # loop through the list of contacts
    # print each contact name and email
  end
  # TODO: Implement user interaction. This should be the only file where you use `puts` and `gets`.
end

contact = ContactList.new
contact.prompt