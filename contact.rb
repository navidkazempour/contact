class Contact < ActiveRecord::Base

  def self.search(term)
    Contact.where("name ILIKE '%#{term}%'").where("email ILIKE '%#{term}%'")
  end

end