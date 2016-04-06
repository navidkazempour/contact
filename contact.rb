require 'csv'
require 'byebug'

# Represents a person in an address book.
# The ContactList class will work with Contact objects instead of interacting with the CSV file directly
class Contact

  attr_accessor :name, :email
  attr_reader :id

  @@max_id = 0
  
  # Creates a new contact object
  # @param name [String] The contact's name
  # @param email [String] The contact's email address
  def initialize(id, name, email)
    # TODO: Assign parameter values to instance variables.
    @name = name
    @email = email
    @id = id
  end


  def self.run
  end

  # Provides functionality for managing contacts in the csv file.
  class << self

    # Opens 'contacts.csv' and creates a Contact object for each line in the file (aka each contact).
    # @return [Array<Contact>] Array of Contact objects
    def all
      # TODO: Return an Array of Contact instances made from the data in 'contacts.csv'.
      contacts = []
      CSV.foreach('contacts.csv') do |row|
        @@max_id = id = row[0].to_i
        contacts << Contact.new(id,row[1],row[2])
      end
      contacts
    end

    def id_generator
      @@max_id += 1
    end

    # Creates a new contact, adding it to the csv file, returning the new contact.
    # @param name [String] the new contact's name
    # @param email [String] the contact's email
    def create(name, email)
      # TODO: Instantiate a Contact, add its data to the 'contacts.csv' file, and return it.
      # step 1: instantiate contact
      new_contact = Contact.new(id_generator, name, email)
      # step 2: add its data to contacts.csv
      contacts_file = File.open("contacts.csv", "a")
      contacts_file.puts "#{new_contact.id}, #{new_contact.name}, #{new_contact.email}" # here you should print name and email with comma
      contacts_file.close
      # step 3: return it
      new_contact
    end
    
    # Find the Contact in the 'contacts.csv' file with the matching id.
    # @param id [Integer] the contact id
    # @return [Contact, nil] the contact with the specified id. If no contact has the id, returns nil.
    def find(id)
      # TODO: Find the Contact in the 'contacts.csv' file with the matching id.
      found = nil
      CSV.foreach('contacts.csv') do |row|
        contact_id = row[0]
        if contact_id == id
          found = Contact.new(row[0], row[1], row[2])
        end
      end
      found
    end
    
    # Search for contacts by either name or email.
    # @param term [String] the name fragment or email fragment to search for
    # @return [Array<Contact>] Array of Contact objects.
    def search(term)
      result = []
      # TODO: Select the Contact instances from the 'contacts.csv' file whose name or email attributes contain the search term.
      CSV.foreach('contacts.csv') do |row|
        # byebug
        if row[1].include?(term)|| row[2].include?(term)
          result << Contact.new(row[0], row[1], row[2])
        end
      end
      result
    end

  end
end