require_relative 'contact'

class ContactList

  def prompt
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

  def delete
    id = ARGV[1]
    find_by_id
    puts "Are you sure you want to delete?"
    ans = STDIN.gets.chomp

    case ans
    when "yes"
      Contact.destroy(id)
    else
      0
    end
  end

  def update
    puts "Matches found:"
    found = find_by_id
    puts "What do you gonna modify on this contact?"
    puts "\tname\n\temail"
    ans = STDIN.gets.chomp

    case ans
    when "name"
      puts "New name please:"
      n_name = STDIN.gets.chomp
      Contact.connection.exec_params("UPDATE contacts SET name = $1 WHERE id = #{@id}", [n_name])
      puts "Changes made."
    when "email"
      puts "New email please:"
      n_email = STDIN.gets.chomp
      Contact.connection.exec_params("UPDATE contacts SET email = $1 WHERE id = #{@id}", [n_email])
      puts "Changes made."
    else
      puts "Wrong input!"
      0
    end
    
  end

  def create_contact
    puts "Name:"  
    name = STDIN.gets.chomp
    puts "e-mail:"
    email = STDIN.gets.chomp
    contact = Contact.create(name,email)
    puts "Contact #{name} with #{email} email created."
  end

  def print_contacts
    contacts = Contact.all
    contacts.each do |contact|
      puts "#{contact.id}: #{contact.name}, #{contact.email}"
    end
  end

  def find_by_id
    id = ARGV[1]
    contact = Contact.find(id)
    if contact
      contact.each{|i| @found = Contact.new(i["id"], i["name"], i["email"])}
      if @found
        puts "#{@found.id}: #{@found.name}, #{@found.email}"
        @id = @found.id
      else
        puts "NO MATCH!"
      end
    else
      puts "No result for this ID, sorry."
      nil
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

end

contact = ContactList.new
contact.prompt
