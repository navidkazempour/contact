require_relative 'setup'

class ContactList

  def self.prompt
    puts "Here is a list of available commands:"
    puts "\tnew\t- Create a new contact"
    puts "\tlist\t- List all contacts"
    puts "\tshow\t- Show a contact"
    puts "\tsearch\t- Search contacts"
    puts "\tupdate\t- Update an existing contact"
    puts "\tdelete\t- delete a contact"
    case ARGV[0] 
    when "new"
      create_contact
    when "list"
      print_contacts
    when "show"
      find_by_id
    when "search"
      search
    when "update"
      update
    when "delete"
      delete
    else
      0
    end 
  end

  def self.delete
    id = ARGV[1]
    @contact = Contact.find(id)
    puts "Are you sure you want to delete?"
    ans = STDIN.gets.chomp

    case ans
    when "yes"
      @contact.destroy
    else
      0
    end
  end

  def self.update
    id = ARGV[1]
    @contact = Contact.find(id)
    puts "What do you gonna modify on this contact?"
    puts "\tname\n\temail"
    ans = STDIN.gets.chomp

    case ans
    when "name"
      puts "New name please:"
      n_name = STDIN.gets.chomp
      @contact.update(name: "#{n_name}")
      puts "Changes made."
    when "email"
      puts "New email please:"
      n_email = STDIN.gets.chomp
      @contact.update(email: "#{n_email}")
      puts "Changes made."
    else
      puts "Wrong input!"
      0
    end
    
  end

  def self.create_contact
    puts "Name:"  
    name = STDIN.gets.chomp
    puts "e-mail:"
    email = STDIN.gets.chomp
    contact = Contact.create(name: name,email: email)
    puts "Contact #{name} with #{email} email created."
  end

  def self.print_contacts
    contacts = Contact.all
    contacts.each do |contact|
      puts "#{contact.id}: #{contact.name}, #{contact.email}"
    end
  end

  def self.find_by_id
    id = ARGV[1]
    contact = Contact.find(id)
    if contact
        puts "#{contact.id}: #{contact.name}, #{contact.email}"
    else
      puts "No result for this ID, sorry."
      nil
    end
  end

  def self.search
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

end

ContactList.prompt
