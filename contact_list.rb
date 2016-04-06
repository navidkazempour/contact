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
      create_contact
    when "list"
      print_contacts
    when "show"
      find_by_id
    when "search"
      search
    end 
  end

  def create_contact
    puts "Name:"  
    name = STDIN.gets.chomp
    puts "e-mail:"
    email = STDIN.gets.chomp
    Contact.all
    contact = Contact.create(name,email)
    puts "#{contact.id}: #{contact.name} , #{contact.email} created!"
  end

  def print_contacts
    contacts = Contact.all
    contacts.each do |contact|
      puts "#{contact.id}: #{contact.name}, #{contact.email}"
    end
  end

  def find_by_id
    puts "ID please:"
    id = STDIN.gets.chomp
    contact = Contact.find(id)
    if contact
      puts "#{contact.id}: #{contact.name}, #{contact.email}"
    else
      puts "No result for this ID, sorry."
    end
  end

  def search
    puts "Enter clue:"
    term = STDIN.gets.chomp
    results = Contact.search(term)
    results.each do |result|
      if result
        puts "Match=> #{result.id}: #{result.name}, #{result.email}"
      else
        nil
      end
    end
  end


  # TODO: Implement user interaction. This should be the only file where you use `puts` and `gets`.
end

contact = ContactList.new
contact.prompt
