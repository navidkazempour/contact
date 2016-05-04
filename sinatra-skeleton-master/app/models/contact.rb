class Contact < ActiveRecord::Base

  validates :name, presence: true
  validates :email, presence: true
  validates :phone_number, presence: true

  def self.search(term)
    Contact.where("name ILIKE '%#{term}%'").where("email ILIKE '%#{term}%'")
  end

end