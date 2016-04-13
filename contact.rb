require 'csv'
require 'byebug'
require 'pg'
require 'pry'

class Contact

  @@max_id = 0

  attr_accessor :name, :email
  attr_reader :id
 
  def initialize(id, name, email)
    @name = name
    @email = email
    @id = id
  end

  def self.connection
    PG.connect(
      host: 'localhost',
      dbname: 'contact_list',
      user: 'development',
      password: 'development')
  end

  def self.run
  end

  class << self

    def destroy(id)
      Contact.connection.exec_params("DELETE FROM contacts WHERE id = $1::int;", [id])
    end

    def all
      contacts = []
      rows = Contact.connection.exec_params("SELECT * FROM contacts;")
      rows.each do |row|
        contacts << Contact.new(row["id"], row["name"], row["email"])
      end
      contacts
    end

    def id_generator
      @@max_id += 1
    end

    def save(name, email)
      Contact.connection.exec_params("INSERT INTO contacts(name, email) VALUES($1, $2);", [name, email])
    end

    def create(name, email)
      save(name, email)

    end
    

    def find(id)
      n = Contact.connection.exec_params("SELECT * FROM contacts WHERE id = $1::int;", [id])
    end
    
    def search(term)
      contacts = []
      found = Contact.connection.exec_params("SELECT * FROM contacts WHERE name ILIKE '%' || $1 || '%' OR email ILIKE '%' || $1 || '%' ;", [term])
      found.each do |row|
        contacts << Contact.new(row["id"], row["name"], row["email"])
      end
      contacts
    end

  end
end